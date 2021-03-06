// Generated by CoffeeScript 1.10.0
(function() {
  var Layout, Nested, Resource, mongoose;

  mongoose = require('mongoose');

  Resource = require('resourcejs');

  Layout = require('../models/layout').model;

  Nested = require('./helpers/nested');

  module.exports = function(app, model) {
    var resource;
    resource = Resource(app, '', 'Rooms', model).rest({
      after: function(req, res, next) {
        return Nested.find('room', Layout, 'layouts', req.method, res.resource.item, function(error, result) {
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

//# sourceMappingURL=rooms.js.map
