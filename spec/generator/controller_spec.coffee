generateController = require('../../generator/generators/controller')

CONTROLLER_EXPECTATION = [ # coffeescript's `"""` removes whitespace
  "class MyCoolApp.PeopleController extends Batman.Controller"
  "  routingKey: 'people'"
  ""
  "  index: (params) ->"
  "    @set 'people', MyCoolApp.Person.get('all')"
  ""
  "  show: (params) ->"
  "    MyCoolApp.Person.find params.id, (err, record) ->"
  "      @set 'person', record"
  ""
  ""
].join("\n")

describe 'Controller Generator', ->

  describe 'class name and super class', ->
    it 'creates an controller with the given name', ->
      code = generateController "PeopleController",
          appName: "MyCoolApp"
          extends: "Batman.Controller"
      lines = code.split("\n")
      expect(lines[0]).toEqual("class MyCoolApp.PeopleController extends Batman.Controller")
      expect(lines[1]).toEqual("  routingKey: 'people'")

    it 'doesnt require "Controller" and defaults to ApplicationController', ->
      code = generateController "People",
          appName: "MyCoolApp"
      lines = code.split("\n")

      expect(lines[0]).toEqual("class MyCoolApp.PeopleController extends MyCoolApp.ApplicationController")
      expect(lines[1]).toEqual("  routingKey: 'people'")

    it 'takes it verbatim if it includes `Controller`', ->
      code = generateController "ApplicationController",
          appName: "MyCoolApp"
          except: "edit,new,index,show"
          skipRoutingKey: true
          extends: "Batman.Controller"
      expect(code).toEqual("class MyCoolApp.ApplicationController extends Batman.Controller\n")

    it 'accepts custom `extends`', ->
      code = generateController "People",
          appName: "MyCoolApp"
          extends: "SpecialController"
      lines = code.split("\n")

      expect(lines[0]).toEqual("class MyCoolApp.PeopleController extends MyCoolApp.SpecialController")

  describe 'actions', ->
    it 'obeys except', ->
      code = generateController "PeopleController",
          appName: "MyCoolApp"
          except: "edit,new"
          extends: "Batman.Controller"
      expect(code).toEqual(CONTROLLER_EXPECTATION)
