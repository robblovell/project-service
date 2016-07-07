async = require('async')
mongoose = require('mongoose')
Resource = require('resourcejs')
module.exports = class Nested
  constructor: () ->
  @find: (Child, childField, method, resources, callback) ->
    FindFunction = (finds, childs, chpos, childid)->
      finds.push((cb) ->

        Child.findById(childid, (error, result) ->
          if error?
            childs[chpos] = error
          else if result?
              childs[chpos] = result

          cb(error, result)
        )
      )


    #if (method != "GET")
    #  callback(null, resources)
    #  return

    if !resources?
      callback("Not Found", null)
      return

    records = null
    if (resources instanceof Array)
      records = resources
    else
      records = [resources]

    finds = []

    for row in records
      data=row
      if typeof(data._doc)!="undefined"
        data=row._doc

      if data[childField] instanceof Array
        for ch,pos in data[childField]
          FindFunction(finds,data[childField], pos, ch)
      else
        FindFunction(finds, data,childField, data[childField])

    async.parallel(finds, (error, result) ->
      if (error?)
        console.log("Error:" + error)

      callback(error, resources)
    )
