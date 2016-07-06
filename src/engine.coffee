RuleEngine = require('node-rules')

module.exports = class Engine

    constructor: (rules) ->
        for rule in rules
            rule.condition = new Function('R',rule.condition)
            rule.consequence = new Function('R',rule.consequence)
        @rules = rules
        @R = new RuleEngine(@rules)

    execute: (facts, callback) ->
        @R.execute(facts,(result) ->
            if(result.result)
                if (typeof result.result is "boolean")
                    callback(null, {})
                else
                    callback(null, result.result)
            else
                callback(null, {})
            return
        )
        