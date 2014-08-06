writeTemplate = require "../write_template"
Inflector = require '../../inflector/inflector'
path = require 'path'

VIEWS_WITH_SAVE = [
  "Edit"
  "New"
  "Form"
]

DEFAULT_VIEW_NAMES = VIEWS_WITH_SAVE.concat(["Index", "Show"])

module.exports = (fullClassName, options) ->
  viewNames = Inflector.fromSingularCamel(fullClassName.replace(/View$/, ''))
  appName = options.appName
  className = viewNames.singular.happyCamel

  superclassName = if options.extends?.indexOf(".") > -1
      options.extends # namespace was specified
    else if options.extends?
      "#{appName}.#{options.extends}"
    else
      "Batman.View"

  hasItem = false
  itemName = null
  modelName = false
  modelFolder = ""

  for viewName in DEFAULT_VIEW_NAMES when !options.skipSave and fullClassName.indexOf(viewName) > -1
    resourceName = className.replace(viewName, "")
    modelWords = Inflector.fromPluralCamel(resourceName)
    modelName = modelWords.singular.happyCamel
    modelFolder = modelWords.plural.underscored

    if viewName in VIEWS_WITH_SAVE
      itemName = modelWords.singular.sadCamel
    options.htmlFile = "#{modelFolder}/#{viewName.toLowerCase()}"
    break

  data = {
    appName
    className
    superclassName
    itemName
    modelName
  }

  fileName = viewNames.singular.underscored + "_view"
  target = if options.dryRun || !options.appRoot?
      undefined
    else
      path.join(options.appRoot, "views", modelFolder, fileName + ".coffee")

  writeTemplate("view", data, target)