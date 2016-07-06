config =
    env: process.env.NODE_ENV || 'local'
    db: process.env.DB || "mongodb://localhost:27017"
    port: process.env.PORT || '3000'
    host: process.env.HOST || 'localhost'
    basepath: "/"
    scheme: process.env.SCHEME || 'https'
    insightsKey: ""
    segementKey: ""
    version: "0.0.1"
    timeout: 15000
devDB="mongodb://bd-rulesservice-dev:iJyHMx2TJBxv2GLFXE1WNinuiC3P5IAZRPIMU55Ctd3xeLjBCSSKJtWoi5hDEk5pTM16TcZbDDUiNbnTV1rAFg==@bd-rulesservice-dev.documents.azure.com:10250/?ssl=true"
switch config.env
# todo:: develop and staging databases
    when 'develop'
        config.db = process.env.DB
        config.basepath = "/"
        config.host = process.env.HOST
        config.schemes = ['http']
    when 'staging'
        config.db = process.env.DB
        config.basepath = "/"
        config.host = process.env.HOST
        config.schemes = ['https']
    when 'production'
        config.db = process.env.DB
        config.basepath = "/"
        config.host = process.env.HOST
        config.schemes = ['https']
    else
        config.db = "mongodb://localhost:27017/rules" #"mongodb://localhost:27017"
        config.basepath = "/"
        config.host = "localhost:3000"
        config.schemes = ['http']

console.log("configuration: "+JSON.stringify(config))
module.exports = config
