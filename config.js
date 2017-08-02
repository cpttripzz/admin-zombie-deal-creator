module.exports = function (runEnv = 'local') {
    return {
        local: {
            adminApiPath: 'http://localhost:3000/api/bizms/v1/resources/',
            cirrusApiPath: 'http://localhost:6021/api/v1/'
        },
        qa02: {
            adminApiPath: 'http://adminbot.qa02.corp.naturalint.com/api/bizms/v1/resources/product_links/',
            cirrusApiPath: 'http://cirrus-bos.qa02.corp.naturalint.com/api/v1/'
        },
        staging: {
            adminApiPath: 'http://adminbot.staging.naturalint.com/api/bizms/v1/resources/product_links/',
            cirrusApiPath: 'http://cirrus-bos.staging.naturalint.com/api/v1/'
        },
    }[runEnv]
};
