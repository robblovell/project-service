RuleEngine = require('node-rules')

#define the rules
rules = [
    {
        "condition" : "R.when(this.transactionTotal < 500);",
        "consequence" : "this.result = false; R.stop();",
        "priority" : 4
    },
    {
        "condition" : "R.when(this.product.SKU == 500 && this.product.price > 20);",
        "consequence" : "this.result = this.product; R.stop();",
        "priority" : 4
    }
]
for rule in rules
    rule.condition = new Function('R',rule.condition)
    rule.consequence = new Function('R',rule.consequence)

facts = {
    product: {
        SKU: 500
        price: 25
    }
    transactionTotal: 499
}


#initialize the rule engine
R = new RuleEngine(rules)

#Now pass the fact on to the rule engine for results
R.execute(facts,(result) ->
    if(result.result)
        console.log("Discount!"+JSON.stringify(result.result))
    else
        console.log("No discount")
)
{"context": {"name":"Rule 1", "seller":"xyz", "SKU":"123"}}
{
    "context": {
        "name": "Rule 1",
        "seller": "xyz",
        "SKU": "123"
    },
    "rules": [
        {
            "condition": "R.when(this.transactionTotal < 500);",
            "consequence": "this.result = false; R.stop();",
            "priority": "10"
        },
        {
            "condition": "R.when(this.product.SKU == 500 && this.product.price > 20);",
            "consequence": "this.product['discount']=20; this.result = this.product; R.stop();",
            "priority": "10"
        }
    ]
}
[
    {
        "context": [{
            "name": "Rule 3",
            "seller": "xyz"
        }],
        "rules": [
            {
                "condition": "R.when(this.transactionTotal < 500);",
                "consequence": "this.result = false; R.stop();",
                "priority": "10"
            },
            {
                "condition": "R.when(this.product.SKU == 500 && this.product.price > 20);",
                "consequence": "this.product['discount']=20; this.result = this.product; R.stop();",
                "priority": "10"
            }
        ]
    }
]
{
    "context": [{
        "name": "Rule 3",
        "seller": "xyz"
    }],
    "fact": {
        "product": {
            "SKU": 500,
            "price": 25
        },
        "transactionTotal": 500
    }
}