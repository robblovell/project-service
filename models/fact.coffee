Mongoose = require('mongoose')
Schema = require('mongoose').Schema

FactSchema = new Schema(
    {
    },
    { strict: false }
)
module.exports = { model: Mongoose.model("Fact", FactSchema), schema: FactSchema }