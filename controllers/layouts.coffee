mongoose = require('mongoose')
Resource = require('resourcejs')

module.exports = (app, model) ->
    resource = Resource(app, '', 'Layouts', model).rest()
    return resource