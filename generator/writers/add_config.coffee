insertIntoFile = require ("./insert_into_file")
writeTemplate = require ("./write_template")
path = require 'path'
fs = require 'fs'

module.exports = addConfig = (key, value, configDir) ->
  configDir ?= process.cwd()
  configFile = path.join(configDir, '.batman_config.json')

  if !fs.existsSync(configFile)
    writeTemplate("config", {}, configFile)
  return unless key? # you can send nothing to just write the config file

  configJSON = JSON.parse(fs.readFileSync(configFile))
  configJSON[key] = value
  fs.writeFileSync(configFile, JSON.stringify(configJSON, undefined, 2))