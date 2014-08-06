writeTemplate = require "../write_template"
Inflector = require '../../inflector/inflector'

path = require 'path'

CONTROLLER_ACTIONS = [
  "index"
  "show"
  "edit"
  "new"
]

module.exports = generateController = (className, options) ->
  appName = options.appName
  if className.indexOf("Controller") > -1
    overrideClassName = className
  controllerNames = Inflector.fromPluralCamel(className.replace(/Controller$/, ''))
  pluralizedClassName = controllerNames.plural.happyCamel
  routingKey = if options.skipRoutingKey
      undefined
    else
      controllerNames.plural.underscored

  superclassName = if options.extends?.indexOf(".") > -1
      options.extends # namespace was specified
    else if options.extends?
      "#{appName}.#{options.extends}"
    else
      "#{appName}.ApplicationController"

  modelName = controllerNames.singular.happyCamel
  itemName = controllerNames.singular.sadCamel
  collectionName = controllerNames.plural.sadCamel

  except = options.except?.split(",") || []
  actions = (a for a in CONTROLLER_ACTIONS when a not in except)

  data = {
    appName
    overrideClassName
    pluralizedClassName
    superclassName
    routingKey
    modelName
    collectionName
    itemName
    actions
  }

  fileName = controllerNames.plural.underscored + "_controller"
  target = if options.dryRun || !options.appRoot?
      undefined
    else
      path.join(options.appRoot, "controllers", fileName + ".coffee")

  writeTemplate("controller", data, target)