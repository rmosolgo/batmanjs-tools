generateApp = require('../../generator/generators/app')

describe 'App Generator', ->
  it 'creates an app with the given name', ->
    appCode = generateApp("CoolApp")
    expect(appCode).toEqual("class @CoolApp extends Batman.App\n")

  it 'creates configs', ->
    appCode = generateApp "CoolApp",
      pathToHTML: "/app/assets/html"
      fetchRemoteHTML: false
    lines = appCode.split("\n")
    expect(lines[0]).toEqual("Batman.config.pathToHTML = \"/app/assets/html\"")
    expect(lines[1]).toEqual("Batman.config.fetchRemoteHTML = false")
    expect(lines[2]).toEqual("")
