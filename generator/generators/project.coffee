mkdirp = require('mkdirp')
path = require('path')
fs = require('fs')

Inflector = require '../../inflector/inflector'
Writer = require('../writer')


PROJECT_FOLDERS = ["models", "controllers", "views", "html", "lib", "vendor", "assets"]

generateProject = (appName, options) ->

  appName = Inflector.transform appName, "camelize", "capitalize"
  appNames = Inflector.fromSingularCamel(appName)
  projectRootFolderName = appNames.singular.underscored
  options.appRoot = projectRootFolderName
  addProjectFolder = (subfolder) ->
    name = path.join(projectRootFolderName, subfolder)
    if !options.dryRun
      Writer.writeTemplate("blank", {}, name + "/.keep")
    name

  except = options.except?.split(",") || []
  createdFolders = for f in PROJECT_FOLDERS when f not in except
    addProjectFolder(f)
  if !options.dryRun
    Writer.addConfig("appName", appName, projectRootFolderName)
  createdFolders

module.exports = generateProject
