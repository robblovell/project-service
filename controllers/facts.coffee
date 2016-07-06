mongoose = require('mongoose')
Resource = require('resourcejs')
Engine = require('../src/engine')
Rule = require('../models/rule').model
typeIsArray = require('./helpers/typeIsArray')

module.exports = (app, model) ->
    resource = Resource(app, '', 'Facts', model).post({
        before: (req, res, next) ->
            facts = req.body.fact
            # find the set of rules that apply to the requested content:
            # todo:: allow partial finds for things like "Context.name": "name".

            if (typeIsArray req.body.context)
                if (req.body.context.length < 1)
                    res.render('error', {
                        message: "No context given",
                        error: {}
                    })
                    return
                req.body.context = req.body.context[0]
            context = { context: {"$elemMatch": req.body.context }}

            Rule.find(context, (error, result) ->
                if error? or result.length < 1
                    res.send("Rules not found")
                else if result?
                    rules = result[0].toObject().rules

                    engine = new Engine(rules)
                    engine.execute(facts, (error, result) ->
                        if(error?)
                            res.render('error', {
                                message: error,
                                error: {}
                            })
                        else
                            res.send(JSON.stringify(result))
                    )
                    return
#
            )
            return
    })
    return resource