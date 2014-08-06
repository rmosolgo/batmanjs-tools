generateProject = require('../../generator/generators/project')

describe 'Generating a new project', ->
  beforeEach ->
    @expectedFolders = [
      "models"
      "controllers"
      "views"
      "html"
      "lib"
      "assets"
      "vendor"
    ]

  it 'makes a bunch of underscored folders', ->
    folders = generateProject("MyGreatApp", {dryRun: true})
    for f in @expectedFolders
      expect("my_great_app/#{f}" in folders).toBe(true)
    expect(folders.length).toEqual(@expectedFolders.length)


  it 'doesnt make folders if options.except comma-separated', ->
    folders = generateProject("MyGreatApp", {
      dryRun: true,
      except: "models,views"
    })
    expect("my_great_app/models" in folders).toBe(false)
    expect("my_great_app/views" in folders).toBe(false)