#!/usr/bin/env node
'use strict';
const program = require('commander');
const dealService = require('./deal-service');
const _ = require('lodash');
program
    .option('-p, --product <product>', 'Product Link Id')
    .option('-s, --site <site>', 'Site Name')
    .option('-l, --link <link>', 'Link Name')
    .parse(process.argv);

const params = ['product','site','link'];
params.forEach(param => {
   if(!program[param]) {
       console.log(`usage: ${[param]}`);
       process.exit(1);
   }
});
dealService.updateProductLink(_.pick(program,params) )
    .then(result => console.log(result))
    .catch(err => console.dir(err));


