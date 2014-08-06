mkdirp = require('mkdirp')
path = require('path')
fs = require('fs')

Inflector = require '../../inflector/inflector'
writeTemplate = require("../write_template")


PROJECT_FOLDERS = ["models", "controllers", "views", "html", "lib", "vendor", "assets"]

generateProject = (appName, options) ->

  appName = Inflector.transform appName, "camelize", "capitalize"
  appNames = Inflector.fromSingularCamel(appName)
  projectRootFolderName = appNames.singular.underscored
  options.appRoot = projectRootFolderName
  addProjectFolder = (subfolder) ->
    name = path.join(projectRootFolderName, subfolder)
    if !options.dryRun
      writeTemplate("blank", {}, name + "/.keep")
    name

  if !options.dryRun
    writeTemplate("config", {appName} ,"#{projectRootFolderName}/.batman_config.json")
  except = options.except?.split(",") || []
  createdFolders = for f in PROJECT_FOLDERS when f not in except
    addProjectFolder(f)
  createdFolders

module.exports = generateProject
