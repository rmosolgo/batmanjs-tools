generateProject = require('./generators/project')
generateApp = require('./generators/app')
generateModel = require('./generators/model')
generateController = require('./generators/controller')
generateView = require('./generators/view')
generateHTML = require('./generators/html')
generateIndex = require('./generators/index')

module.exports = class Generator
  constructor: (@argv) ->
    @action = @argv._.shift()
    @className = @argv._.shift()
    # console.log @argv.appName, @action, @className

  dispatch: ->
    @[@action]()

  project: ->
    generateProject(@className, @argv)
    @argv.appName = @className
    generateApp(@className, @argv)
    if !@argv.skipIndex
      generateIndex(null, @argv)
    # create application controller
    @argv.appName = @className
    @argv.skipRoutingKey = true
    @argv.except = "show,index,edit,new"
    @argv.extends = "Batman.Controller"
    generateController("ApplicationController", @argv)


  app: ->
    generateApp(@className, @argv)

  model: ->
    @argv.attributes = @argv._ # all other args are attributes
    generateModel(@className, @argv)

  controller: ->
    generateController(@className, @argv)

  view: ->
    generateView(@className, @argv)
    if @argv.html
      generateHTML(@argv.htmlFile, @argv)

  html: ->
    generateHTML(@className, @argv)

  index: ->
    generateIndex(null, @argv)