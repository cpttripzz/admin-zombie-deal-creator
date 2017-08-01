'use strict';
const Promise = require('bluebird');
const rp =  require('request-promise');
const equal = require('deep-equal');
const _ = require('lodash');

let dealService = {};

dealService.updateProductLink = async function updateProductLink(options) {
    try {
        const apiOptions = {json: true,method: 'GET'};
        const {product,site,link} = options;
        const config = require('./config');
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

        // const productResult = `${cirrusApiPath}product_links?count=100000&format=json&joins=partnerUrl&partnerId=`

        const adminVersionsUri = `${adminApiPath}product_links/${productLinkId}/versions.json`;
        let uri = adminApiPath;

        // const versions = await rp(options);
        let versions =  JSON.parse('[{"id":19152,"account_id":565,"url":"http://mcafee-consumer-affiliate.evyy.net/c/34020/257432/3165?subId1=AFF\u0026subid2=[tracking-subid]","deal":[{"deal_type":"Cpa","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"66.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null}],"product_lists":null,"affiliate_link_type":"SubID link","link_name":"Antivirus US SA Current","active":true,"effective_date":"2016-04-18T09:09:21"},{"id":19152,"account_id":565,"url":"http://mcafee-consumer-affiliate.evyy.net/c/34020/257432/3165?subId1=AFF\u0026subid2=[tracking-subid]","deal":[{"deal_type":"Cpa","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"66.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null}],"product_lists":null,"affiliate_link_type":"SubID link","link_name":"Antivirus US SA Current","active":true,"effective_date":"2016-06-05T13:06:17"},{"id":19152,"account_id":565,"url":"http://mcafee-consumer-affiliate.evyy.net/c/34020/257432/3165?subId1=AFF\u0026subid2=[tracking-subid]","deal":[{"deal_type":"Cpa","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"66.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null}],"product_lists":null,"affiliate_link_type":"SubID link","link_name":"Antivirus US SA Current","active":true,"effective_date":"2016-07-11T07:25:13"},{"id":19152,"account_id":565,"url":"http://mcafee-consumer-affiliate.evyy.net/c/34020/257432/3165?subId1=AFF\u0026subid2=[tracking-subid]","deal":[{"deal_type":"Cpa","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"66.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null}],"product_lists":null,"affiliate_link_type":"SubID link","link_name":"Antivirus US SA Current","active":true,"effective_date":"2016-07-12T06:48:45"},{"id":19152,"account_id":565,"url":"http://mcafee-consumer-affiliate.evyy.net/c/34020/257432/3165?subId1=AFF\u0026subid2=[tracking-subid]","deal":[{"deal_type":"Cpa","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"66.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null}],"product_lists":null,"affiliate_link_type":"SubID link","link_name":"Antivirus US SA Current","active":true,"effective_date":"2017-01-25T14:22:26"},{"id":19152,"account_id":565,"url":"http://mcafee-consumer-affiliate.evyy.net/c/34020/257432/3165?subId1=AFF\u0026subid2=[tracking-subid]","deal":[{"deal_type":"Cpa","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"90.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null}],"product_lists":null,"affiliate_link_type":"SubID link","link_name":"Antivirus US SA Current","active":true,"effective_date":"2017-05-16T12:09:17"},{"id":19152,"account_id":565,"url":"http://mcafee-consumer-affiliate.evyy.net/c/34020/257432/3165?subId1=AFF\u0026subid2=[tracking-subid]","deal":[{"deal_type":"Cpa","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"100.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null}],"product_lists":null,"affiliate_link_type":"SubID link","link_name":"Antivirus US SA Current","active":true,"effective_date":"2017-07-31T13:10:39"},{"id":19152,"account_id":565,"url":"http://mcafee-consumer-affiliate.evyy.net/c/34020/257432/3165?subId1=AFF\u0026subid2=[tracking-subid]","deal":[{"deal_type":"Cpa","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"100.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null},{"deal_type":"Cpl","currency":"USD","clicks_source":null,"rules":[{"type":"Deals::ValueRangeRule","value":"90.0","range_start":"0.0","range_end":"9999999999999.99","date_range_start":null,"date_range_end":null,"period_type":"Custom"}],"comment":null}],"product_lists":null,"affiliate_link_type":"SubID link","link_name":"Antivirus US SA Current","active":true,"effective_date":"2017-08-01T07:59:09"}]');
        const uniqueVersions = versions.reduce( (acc, next) => {
            const found = acc.filter( oldValue => equal(oldValue,next));
            if(! found.length) acc.push(next);
        },[]);
            return acc;
        console.dir(productLinkId);

    } catch (err) {
        console.log(err);
        throw err;
    }
};


module.exports = dealService;

