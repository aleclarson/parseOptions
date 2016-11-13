
Type = require "Type"

parseOptions = require ".."

describe "parseOptions", ->

  it "traverses the 'optionTypes' of the given type and its supertypes", ->

    A = createType
      options: {a: Number, b: Number}

    B = createType
      inherits: A

    C = createType
      inherits: B
      options: {c: String}

    opts = parseOptions C, {a: 0, c: "", d: 1}
    expect(opts.a).toBe 0
    expect(opts.b).toBe undefined
    expect(opts.c).toBe ""
    expect(opts.d).toBe undefined

createType = ({ inherits, options }) ->
  type = Type()
  type.inherits inherits if inherits
  type.defineOptions options if options
  return type.build()
