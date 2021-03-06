Mongoose = require('mongoose')
Schema = require('mongoose').Schema

ObjectId = Mongoose.Schema.Types.ObjectId

RoomSchema = new Schema({

    project: {
        type: ObjectId
        ref: 'Project'
        index: true
        require: true
    }
    layouts : [{ type: ObjectId, ref: 'Layout' }]
    placeables : [{ type: ObjectId, ref: 'Placeable' }]
})
RoomModel = Mongoose.model("Room", RoomSchema)
module.exports = { model: RoomModel, schema: RoomSchema }

