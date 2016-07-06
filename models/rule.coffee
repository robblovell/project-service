Mongoose = require('mongoose')
Schema = require('mongoose').Schema
RuleSchema = new Schema(
    {
        condition: String
        consequence: String
        priority: String
    }
)
ContextSchema = new Schema(
    {
        name: String
        schema: String
    },
    { strict: false }
)
FactSchema = new Schema(
    {
        name: String
    },
    { strict: false }
)
RulesSchema = new Schema(
    {
        context: [ContextSchema],
        rules: [RuleSchema],
        factSchema: [FactSchema]
    }

)
module.exports = { model: Mongoose.model("Rules", RulesSchema), schema: RulesSchema }