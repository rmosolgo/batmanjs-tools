Writer = require "../writer"
Inflector = require '../../inflector/inflector'
path = require 'path'


module.exports = (className, options) ->
  appNames = Inflector.fromSingularCamel(options.appName)
  appName = appNames.singular.happyCamel
  appFileName = appNames.singular.underscored

  data = {
    appName
    appFileName
  }

  target = if options.dryRun || !options.appRoot?
      undefined
    else
      path.join(options.appRoot, "index.html")

  Writer.writeTemplate("index", data, target)
  options.hasIndexHTML = true
  Writer.addConfig("hasIndexHTML", true, options.appRoot)