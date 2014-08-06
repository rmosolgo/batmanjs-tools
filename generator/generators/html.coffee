writeTemplate = require "../write_template"
Inflector = require '../../inflector/inflector'
path = require 'path'


DEFAULT_TEMPLATE_NAMES = [
  "index"
  "edit"
  "new"
  "form"
  "show"
]

generateDefaultHTML = (filepath, options) ->
  [folderName, templateName] = filepath.split("/")
  resourceNames = Inflector.fromPluralUnderscored(folderName)

  capitalizedCollectionName =   resourceNames.plural.happyCamel
  collectionName =              resourceNames.plural.sadCamel
  resourceName =                resourceNames.plural.underscored
  humanizedCollectionName =     resourceNames.plural.humanized

  capitalizedItemName =         resourceNames.singular.happyCamel
  itemName =                    resourceNames.singular.sadCamel
  humanizedItemName =           resourceNames.singular.humanized
  lowercasedItemName =          resourceNames.singular.downcased

  data = {
    resourceName
    folderName
    capitalizedCollectionName
    humanizedCollectionName
    collectionName
    itemName
    lowercasedItemName
    capitalizedItemName
    humanizedItemName
  }

  target = if options.dryRun || !options.appRoot?
      undefined
    else
      path.join(options.appRoot, "html", filepath + ".html")

  writeTemplate("html_" + templateName, data, target)

module.exports = (filepath, options) ->
  pathParts = filepath.split("/")
  if pathParts.length is 2 and pathParts[1] in DEFAULT_TEMPLATE_NAMES
    generateDefaultHTML(filepath, options)
  else
    writeTemplate("blank", {}, "html/" + filepath + ".html")
