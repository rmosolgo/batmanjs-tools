generateModel = require('../../generator/generators/model')

describe 'Model generator', ->

  it 'defaults superclass and resourceName', ->
    modelCode = generateModel("MyApp.MyModel", {})
    lines = modelCode.split("\n")
    expect(lines[0]).toEqual("class MyApp.MyModel extends Batman.Model")
    expect(lines[1]).toEqual("  @resourceName: \"my_model\"")
    expect(lines[2]).toMatch(/@persist/)

  it 'takes attributes', ->
    modelCode = generateModel("MyApp.MyModel", {attributes: ["hands", "feet"]})
    lines = modelCode.split("\n")
    expect(lines[3]).toEqual("  @encode \"hands\", \"feet\"")


  describe 'storageAdapter option', ->
    beforeEach ->
      @testAdapterArg = (storageAdapter, opts={}) ->
        opts.storageAdapter = storageAdapter
        code = generateModel("MyApp.MyModel", opts)
        code.split("\n")[2].match(/sist (.*)/)[1]

    it 'takes batman adapters with namespace', ->
      expect(@testAdapterArg("Batman.RailsStorage")).toEqual("Batman.RailsStorage")
    it 'takes batman adapters without namespace', ->
      expect(@testAdapterArg("RailsStorage")).toEqual("Batman.RailsStorage")
    it 'takes custom adapters', ->
      expect(@testAdapterArg("SillyStorage"), {appName: "MyApp"}).toEqual("MyApp.SillyStorage")
    it 'takes nothing', ->
      expect(@testAdapterArg(undefined)).toBeDefined()