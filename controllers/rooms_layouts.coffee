mongoose = require('mongoose')
Resource = require('resourcejs')

module.exports = (app, model) ->
    resource = Resource(app, '/rooms/:roomId', 'Layouts', model).rest({
        before: (req, res, next) ->
            req.body.room = req.params.roomId
            req.modelQuery = this.model.where('room', req.params.roomId)
            next()

    }).patch({
        before: (req, res, next) ->
            traverse = require('./helpers/traverse')

            if not(req.body? and req.body[0]? and req.body[0].op?)
                result = traverse(req.body[0],'', [])
                req.body[0] = result[0]
            next()
    })
    resource.modelName = resource.modelName.substring(0,resource.modelName.length-1)
    return resource
