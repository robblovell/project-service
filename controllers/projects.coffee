mongoose = require('mongoose')
Resource = require('resourcejs')
Room = require('../models/room').model
Nested = require './helpers/nested'

module.exports = (app, model) ->
    resource = Resource(app, '', 'Projects', model).rest({
        after: (req, res, next) ->
            Nested.find('project', Room, 'rooms', req.method, res.resource.item, (error, result) ->
                next()
            )
    }).patch({
        before: (req, res, next) ->
            traverse = require('../../src/traverse')

            if not(req.body? and req.body[0]? and req.body[0].op?)
                result = traverse(req.body[0],'', [])
                req.body[0] = result[0]
            next()
    })

    return resource