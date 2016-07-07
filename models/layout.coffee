Mongoose = require('mongoose')
Schema = require('mongoose').Schema

ObjectId = Mongoose.Schema.Types.ObjectId

LayoutSchema = new Schema({

    room: {
        type: ObjectId
        ref: 'Room'
        index: true
        require: true
    }
})
LayoutModel = Mongoose.model("Layout", LayoutSchema)
module.exports = { model: LayoutModel, schema: LayoutSchema }