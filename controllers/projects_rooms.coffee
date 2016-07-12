mongoose = require('mongoose')
Resource = require('resourcejs')

Nested = require './helpers/Nested'
#Nested2 = require './helpers/Nested2'

module.exports = (app, model, Placeable, Layout) ->
    resource = Resource(app, '/projects/:projectId', 'Rooms', model).rest({
        before: (req, res, next) ->
            req.body.project = req.params.projectId
            req.modelQuery = this.model.where('project', req.params.projectId)
            next()
        after: (req, res, next) ->
#            Nested2.find(Layout, 'layouts', req.method, res.resource.item, (error, result) ->
#                next()
#            )
            Nested.find('room', Layout, 'layouts', req.method, res.resource.item, (error, result) ->
                Nested.find('room', Placeable, 'placeables', req.method, res.resource.item, (error, result) ->
                    next()
                )
            )
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
