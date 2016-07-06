// Generated by CoffeeScript 1.10.0
(function() {
  var R, RuleEngine, fact, i, len, rule, rules;

  RuleEngine = require('node-rules');

  rules = [
    {
      "id": 1,
      "condition": "R.when(this && (this.transactionTotal < 500))",
      "consequence": "this.result = false; R.stop()"
    }, {
      "id": 2,
      "condition": "R.when(this && (this.transactionTotal >= 500))",
      "consequence": "this.result = true; R.stop()"
    }
  ];

  for (i = 0, len = rules.length; i < len; i++) {
    rule = rules[i];
    rule.condition = new Function('R', rule.condition).bind(this);
    rule.consequence = new Function('R', rule.consequence).bind(this);
  }

  fact = {
    "name": "user4",
    "application": "MOB2",
    "transactionTotal": 600,
    "cardType": "Credit Card"
  };

  R = new RuleEngine(rules, {
    ignoreFactChanges: true
  });

  R.execute(fact, function(result) {
    if (result.result) {
      return console.log("Payment Accepted");
    } else {
      return console.log("Payment Rejected");
    }
  });

}).call(this);

//# sourceMappingURL=rules_example_simple_string.js.map
