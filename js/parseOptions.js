// Generated by CoffeeScript 1.12.4
var OneOf, emptyFunction, getProto, getSuperType, parseOptions;

emptyFunction = require("emptyFunction");

getProto = require("getProto");

OneOf = require("OneOf");

parseOptions = function(type, values, options) {
  var i, ignored, key, len, parsed, ref, ref1, superKey, superType, types;
  if (options == null) {
    options = {};
  }
  parsed = {};
  ignored = options.ignore ? OneOf(options.ignore) : {
    test: emptyFunction.thatReturnsFalse
  };
  superKey = (ref = options.key) != null ? ref : "optionTypes";
  superType = type;
  while (true) {
    if (types = superType[superKey]) {
      ref1 = Object.keys(types);
      for (i = 0, len = ref1.length; i < len; i++) {
        key = ref1[i];
        if (values[key] === void 0) {
          continue;
        }
        if (ignored.test(key)) {
          continue;
        }
        parsed[key] = values[key];
      }
    }
    superType = getSuperType(superType);
    if (superType === Object) {
      break;
    }
  }
  if (options.assign) {
    Object.assign(parsed, options.assign);
  }
  return parsed;
};

getSuperType = function(type) {
  return getProto(type.prototype).constructor;
};

module.exports = parseOptions;