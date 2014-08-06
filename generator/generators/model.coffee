path = require "path"
writeTemplate = require "../write_template"
Inflector = require '../../inflector/inflector'


BATMAN_STORAGE_ADAPTERS = [
  "LocalStorage"
  "SessionStorage"
  "RestStorage"
  "RailsStorage"
]

_prefixWithApp = (name, appName) ->
  if "." not in name
    name = "#{appName}.#{name}"
  name

generateModel = (className, options) ->
  nameParts = className.split(".")
  className = nameParts.pop()

  modelNames = Inflector.fromSingularCamel(className)
  fileName = modelNames.singular.underscored

  appName = nameParts.pop() || options.appName

  superclassName = _prefixWithApp(options.extends || "Batman.Model", appName)

  resourceName = options.resourceName || fileName

  storageAdapter = if options.storageAdapter in BATMAN_STORAGE_ADAPTERS
      # batman storage adapters don't need `Batman` namespace
      "Batman.#{options.storageAdapter}"
    else if options.storageAdapter? and "Batman." in options.storageAdapter
      # but if `Batman` namespace is provided, that's cool
      options.storageAdapter
    else if options.storageAdapter?
      # otherwise, assume it's an app-specific storage adapter
      _prefixWithApp(options.storageAdapter, appName)
    else
      "\"Don't forget a storage adapter, like Batman.RestStorage!\""

  attributes = options.attributes || []

  data = {
    appName
    className
    superclassName
    resourceName
    storageAdapter
    attributes
  }

  target = if options.dryRun || !options.appRoot?
      undefined
    else
      path.join(options.appRoot, "models", fileName + ".coffee")
  writeTemplate("model", data, target)

module.exports = generateModel