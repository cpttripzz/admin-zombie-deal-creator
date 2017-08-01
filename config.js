module.exports = {
    local: {
        adminApiPath: 'http://localhost:3000/api/bizms/v1/resources/',
        cirrusApiPath: 'http://localhost:6021/api/v1/'
    },
    qa02: {
        adminApiPath: 'http://adminbot.qa02.corp.naturalint.com/api/bizms/v1/resources/product_links/'
    }
}[process.env.RUN_ENV || 'local'];
