
getProto = require "getProto"

parseOptions = (type, options) ->

  parsed = {}

  superType = type
  loop
    if optionTypes = superType.optionTypes
      for key in Object.keys optionTypes
        if options[key] isnt undefined
          parsed[key] = options[key]

    superType = getSuperType superType
    break if superType is Object

  return parsed

getSuperType = (type) ->
  getProto(type.prototype).constructor

module.exports = parseOptions
