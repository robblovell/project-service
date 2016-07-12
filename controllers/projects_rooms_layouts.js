// Generated by CoffeeScript 1.10.0
(function() {
  var Nested, Resource, mongoose;

  mongoose = require('mongoose');

  Resource = require('resourcejs');

  Nested = require('./helpers/Nested');

  module.exports = function(app, model, Layout) {
    var resource;
    resource = Resource(app, '/projects/:projectId/rooms/:roomId', 'Layouts', model).rest({
      before: function(req, res, next) {
        req.body.project = req.params.projectId;
        req.modelQuery = this.model.where('project', req.params.projectId);
        return next();
      },
      after: function(req, res, next) {
        return Nested.find('room', Layout, 'layouts', req.method, res.resource.item, function(error, result) {
          return next();
        });
      }
    }).patch({
      before: function(req, res, next) {
        var result, traverse;
        traverse = require('./helpers/traverse');
        if (!((req.body != null) && (req.body[0] != null) && (req.body[0].op != null))) {
          result = traverse(req.body[0], '', []);
          req.body[0] = result[0];
        }
        return next();
      }
    });
    resource.modelName = resource.modelName.substring(0, resource.modelName.length - 1);
    return resource;
  };

}).call(this);

//# sourceMappingURL=projects_rooms_layouts.js.map
