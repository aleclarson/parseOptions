
emptyFunction = require "emptyFunction"
getProto = require "getProto"
OneOf = require "OneOf"

parseOptions = (type, values, options = {}) ->

  parsed = {}

  ignored =
    if options.ignore
    then OneOf options.ignore
    else {test: emptyFunction.thatReturnsFalse}

  superType = type
  loop
    if types = superType.optionTypes
      for key in Object.keys types
        continue if values[key] is undefined
        continue if ignored.test key
        parsed[key] = values[key]

    superType = getSuperType superType
    break if superType is Object

  if options.assign
    Object.assign parsed, options.assign

  return parsed

getSuperType = (type) ->
  getProto(type.prototype).constructor

module.exports = parseOptions
