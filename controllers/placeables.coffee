mongoose = require('mongoose')
Resource = require('resourcejs')

module.exports = (app, model) ->
    resource = Resource(app, '', 'Placeables', model).rest()
    return resource