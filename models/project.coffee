Mongoose = require('mongoose')
Schema = require('mongoose').Schema

ObjectId = Mongoose.Schema.Types.ObjectId

ProjectSchema = new Schema({
    rooms : [{ type: ObjectId, ref: 'Room' }]
})
module.exports = { model: Mongoose.model("Project", ProjectSchema), schema: ProjectSchema }