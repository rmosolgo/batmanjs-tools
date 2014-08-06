writeTemplate = require('../write_template')
Inflector = require '../../inflector/inflector'
path = require('path')

BATMAN_CONFIGS = [
  "pathToHTML"
  "fetchRemoteHTML"
  "pathToApp"
  "usePushState"
  "protectFromCSRF"
  "metaNameForCSRFToken"
  "cacheViews"
]

generateApp = (className, options={}) ->
  words = Inflector.fromSingularCamel(className)
  appConfigs = {}
  for key, value of options when key in BATMAN_CONFIGS
      appConfigs[key] = value

  data = {
    className
    appConfigs
  }
  target = if options.dryRun || !options.appRoot?
      undefined
    else
      appFileName = words.singular.underscored
      path.join(options.appRoot, appFileName + ".coffee")
  writeTemplate("app", data, target)

module.exports = generateApp