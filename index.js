#!/usr/bin/env node
'use strict';
const program = require('commander');
const dealService = require('./deal-service');
const _ = require('lodash');
const csv = require('fast-csv');
const fs = require('fs');
const winston = require('winston');

program
    .option('-p, --product <product>', 'Product Name')
    .option('-s, --site <site>', 'Site Name')
    .option('-l, --link <link>', 'Link Name')
    .option('-u, --allow-update <allowUpdate>', 'Allow Updates/ Deletions of existing deals')
    .option('-f, --file <file>', 'Csv file path of new deals')
    .option('-r, --run-env <runEnv>', 'What Environment to run script')

    .parse(process.argv);

const params = ['product', 'site', 'link', 'file'];
params.forEach(param => {
    if (!program[param]) {
        console.log(`usage: ${param}`);
        process.exit(1);
    }
});

if (!fs.existsSync(program.file)) {
    console.log(`${program.file} does not exist`);
    process.exit(1);
}
const newDeals = [];
const stream = fs.createReadStream(program.file);
winston.add(winston.transports.File, { filename: './api-input.log' });
const optionalParams = ['allowUpdate', 'runEnv'];
optionalParams.forEach(p => {
    if(program[p]) {
        params.push(p);
    }
});

csv.fromStream(stream)
    .on('data', data => newDeals.push(data))
    .on('end', () => {
        console.log('load successful');
        dealService.updateProductLink(Object.assign({newDeals},_.pick(program, params)))
            .then(result => winston.log('info', '', { newDeals, result }))
            .catch(err => winston.log('error', '', { result: err.message}))
    });