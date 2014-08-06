generateView = require('../../generator/generators/view')

describe "View generator", ->
  it 'generates a view with the right name and default superview', ->
    code = generateView("EventsIndexView", {
      appName: "MyCoolApp"
    })
    expect(code).toEqual("class MyCoolApp.EventsIndexView extends Batman.View\n")

  it 'takes a custom extends', ->
    code = generateView("EventsIndexView", {
      appName: "MyCoolApp"
      extends: "ListView"
    })
    expect(code).toEqual("class MyCoolApp.EventsIndexView extends MyCoolApp.ListView\n")

  it 'creates a save function when appropriate', ->
    code = generateView("PeopleEditView", {
      appName: "MyCoolApp"
    })
    lines = code.split("\n")
    expect(lines[2]).toEqual("  savePerson: ->")