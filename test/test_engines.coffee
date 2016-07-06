# todo:: write unit tests for this thing I wrote too quickly leveraging too many things.
should = require('should')
assert = require('assert')
Engine = require('../src/engine')

describe 'Engines', () ->

    rules = [{
        "id": 1,
        "condition": "R.when(this.transactionTotal > 500)"
        ,
        "consequence": "this.result = 1; R.stop()"
    }]
    facts = {
        transactionTotal: 1000
    }
    engine = null

    before () ->
        engine = new Engine(rules)

    it 'instantiates', () ->
        engine.rules.should.be.ok
        engine.R.should.be.ok
        for rule in engine.rules
            rule.should.be.ok

        return

    it 'executes', () ->
        engine.execute(facts, (error, results) ->
            results.should.be.ok
            results.should.be.equal(1)
            return
        )