### Rules-Server
Add rules by posting to the "Rules Resource" at [http://localhost:3000/rules](http://localhost:3000/rules).  A context is used to group rule sets together.

Post a fact to the "Facts Resource" at [http://localhost:3000/facts](http://localhost:3000/facts) with a context specified and the rules associated with that context will check the fact and fire and give a result.

An example context with a set of rules.
```
{
  "context": [{
    "name": "Rule 1",
    "seller": "xyz",
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
```

An example fact to use with the given context
```
{
  "context": [{
    "name": "Rule 1",
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
```

The reply is: `{"SKU":500,"price":25,"discount":20}`

Swagger documentation is at: [http://localhost:3000/docs](http://localhost:3000/docs/index.html)

The server uses a mongodb driver to persist rules and uses expressjs, resourcejs, mongoose to create the REST interface. The rules are implemented with node-rules.

TODO: 
ability to switch rules engines (nools is a candidate). 
