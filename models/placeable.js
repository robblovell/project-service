// Generated by CoffeeScript 1.10.0
(function() {
  var Mongoose, ObjectId, PlaceableModel, PlaceableSchema, Schema;

  Mongoose = require('mongoose');

  Schema = require('mongoose').Schema;

  ObjectId = Mongoose.Schema.Types.ObjectId;

  PlaceableSchema = new Schema({
    room: {
      type: ObjectId,
      ref: 'Room',
      index: true,
      require: true
    }
  });

  PlaceableModel = Mongoose.model("Placeable", PlaceableSchema);

  module.exports = {
    model: PlaceableModel,
    schema: PlaceableSchema
  };

}).call(this);

//# sourceMappingURL=placeable.js.map
