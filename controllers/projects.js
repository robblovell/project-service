// Generated by CoffeeScript 1.10.0
(function() {
  var Nested, Resource, Room, mongoose;

  mongoose = require('mongoose');

  Resource = require('resourcejs');

  Room = require('../models/room').model;

  Nested = require('./helpers/nested');

  module.exports = function(app, model) {
    var resource;
    resource = Resource(app, '', 'Projects', model).rest({
      after: function(req, res, next) {
        return Nested.find('project', Room, 'rooms', req.method, res.resource.item, function(error, result) {
          return next();
        });
      }
    }).patch({
      before: function(req, res, next) {
        var result, traverse;
        traverse = require('../../src/traverse');
        if (!((req.body != null) && (req.body[0] != null) && (req.body[0].op != null))) {
          result = traverse(req.body[0], '', []);
          req.body[0] = result[0];
        }
        return next();
      }
    });
    return resource;
  };

}).call(this);

//# sourceMappingURL=projects.js.map
