'use strict';
const Promise = require('bluebird');
const rp =  require('request-promise');
const equal = require('deep-equal');
const _ = require('lodash');
const winston = require('winston');
const uuid = require('uuid/v4');

const periodTypes = ['Custom', 'Monthly', 'Daily', 'Quarterly', 'Weekly'];
const sources = ['NI Tracker Clicks', 'NI Tracker Unique Clicks', 'Partner Clicks', 'Partner Unique Clicks',
        'Google Analytics Clicks', 'Google Analytics Unique Clicks'];
const currencies = ['AUD', 'EUR', 'GBP', 'USD'];
let dealService = {};
const dealTypes=["Cpa", "Cpl", "Cpc", "Epc", "Rev Share", "Flat Fee"];

function setSource(dealContract, source) {
    if(! sources.includes(source)){
        throw new Error('invalid source');
    }
    return Object.assign(dealContract, {clicks_source: source});
}
function setPeriodType(dealContract, periodTypeData) {
    const periodType = periodTypeData.shift();
    const newDeal = Object.assign(dealContract, {});
    if(! periodTypes.includes(periodType)){
        throw new Error('invalid period type');
    }
    if (periodType === 'Custom') {
        const periods = periodTypeData.split('-');
        if(!periods.length) {
            throw new Error('invalid custom period date range');
        }
        _.set(newDeal, 'rules[0].date_range_start', periods[0]);
        _.set(newDeal, 'rules[0].date_range_end', periods[1]);
    }
    _.set(newDeal, 'rules[0].period_type',periodType);

}
dealService.populateDeal = function populateDeal(deal){
    const dealType = deal.shift();
    const value = deal.shift();
    const currency = deal.shift();

    if (! dealTypes.includes(dealType)) {
        throw new Error('invalid deal type');
    }

    let dealContract = require(`./deal-formats/json/${_.kebabCase(dealType)}`);
    _.set(dealContract, 'rules[0].value', value);

    const now = new Date().toISOString().slice(0, 10);
    _.set(dealContract, 'rules[0].date_range_start', now);
    _.set(dealContract, 'rules[0].date_range_end', now);
    if(! currencies.includes(currency)) {
        throw new Error('invalid currency');
    }

    dealContract.currency = currency;
    switch(dealType){
        case 'cpc':
            dealContract = setSource(dealContract, deal.shift());
            break;
        case 'epc':
            const epcValue = deal.shift();
            _.set(dealContract, 'rules[1].value', epcValue/100);
            _.set(dealContract, 'rules[1].value_percent', epcValue);
            dealContract = setPeriodType(dealContract, deal.shift());
            dealContract = setSource(dealContract, deal.shift());
            break;
        case 'revshare':
            const revshareValue = deal.shift();
            _.set(dealContract, 'rules[1].value', revshareValue/100);
            _.set(dealContract, 'rules[1].value_percent', revshareValue);
            break;
        case 'flat':
            dealContract = setPeriodType(dealContract, deal.shift());

            break;
    }
    return dealContract;
}
dealService.updateProductLink = async function updateProductLink(options) {
    try {
        const apiOptions = {json: true,method: 'GET'};
        const {product,site,link,newDeals,allowUpdate,runEnv} = options;
        const config = require('./config')(runEnv);
        const {adminApiPath,cirrusApiPath} = config;
        const productLookup = `${cirrusApiPath}products?name=${product}`;
        const productResult = await rp(Object.assign(apiOptions,{uri :productLookup}));
        // const siteId =
        if (! _.get(productResult, 'content[0].partnerId')) {
            throw new Error('Error: Product not found');
        }
        const partnerId = _.get(productResult, 'content[0].partnerId');
        const productLinkCirrusLookup = `${cirrusApiPath}product_links?count=100000&format=json&joins=partnerUrl&partnerId=${partnerId}`;
        const productLinkCirrusLookupResult = await rp(Object.assign(apiOptions,{uri :productLinkCirrusLookup}));
        if (! _.get(productLinkCirrusLookupResult, 'content[0]')) {
            throw new Error('Error: Link  not found');
        }
        const productLink = productLinkCirrusLookupResult.content.filter(pl =>_.get(pl, 'partnerUrl.name') === link);
        if (! _.get(productLink, '[0].niId')) {
            throw new Error('Error: Link  not found');
        }
        const productLinkId = _.get(productLink, '[0].niId');
        const adminLinkUri = `${adminApiPath}product_links/${productLinkId}.json`;
        const adminLinkUriResult = await rp(Object.assign(apiOptions,{uri: adminLinkUri}));
        const newFormattedDeals = newDeals.map(dealService.populateDeal);
        const {deal} = adminLinkUriResult;

        const oldDealTypes = deal.map(d => d.deal_type);
        if(!allowUpdate) {
            const foundDeals = newFormattedDeals.filter(d => oldDealTypes.includes(d.deal_type));
            if (foundDeals.length) {
                throw new Error(`Error: Deal types: ${foundDeals.map(d => d.deal_type).join()} already in use`);
            }
        }

        newFormattedDeals.forEach((newDeal) => {
            _.remove(deal, obj => obj.deal_type === newDeal.deal_type);
            deal.push(newDeal);
        });

        const fromDate = new Date().toISOString().slice(0, 10);
        const body = Object.assign(adminLinkUriResult, { fromDate,update_type: "publish_campaign",deal})
        const putOptions = Object.assign(apiOptions,{uri: adminLinkUri,body ,method: 'PUT'});
        winston.log('info', '', { putOptions });
        return rp(putOptions);

    } catch (err) {
        console.log(err);
        throw err;
    }
};


module.exports = dealService;

