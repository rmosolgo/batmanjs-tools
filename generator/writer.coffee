writeTemplate = require './writers/write_template'
insertIntoFile = require './writers/insert_into_file'
addConfig = require './writers/add_config'
path = require 'path'

addJavaScriptFile = (filePath, options) ->
  scriptTag = "\n    <script type='text/javascript' src='#{filePath}'></script>"
  headRegExp = /\n\s*<\/head>/
  indexHTML = path.join(options.appRoot, "index.html")
  console.log "  --> HTML <script> #{filePath}"
  insertIntoFile(indexHTML, scriptTag, before: headRegExp)

module.exports = Writer = {
  writeTemplate
  insertIntoFile
  addConfig
  addRoute: 0
  addJavaScriptFile
}

