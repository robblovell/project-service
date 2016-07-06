RuleEngine = require('node-rules')

#define the rules
rules = [{

    "id": 1,
    "condition": (R) ->
        R.when(this && (this.transactionTotal > 500))
    ,
    "consequence": (R) ->
        this.result = false
        R.stop()
    }]

#sample fact to run the rules on
fact = {
    "name":"user4",
    "application":"MOB2",
    "transactionTotal":400,
    "cardType":"Credit Card",
}

#initialize the rule engine
R = new RuleEngine(rules, {ignoreFactChanges: true})

#Now pass the fact on to the rule engine for results
R.execute(fact,(result) ->
    if(result.result)
        console.log("Payment Accepted")
    else
        console.log("Payment Rejected")
)