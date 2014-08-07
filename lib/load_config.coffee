module.exports = loadConfig = (cwd) ->
  cwd ?= process.cwd()
  try
    batmanConfig = require("#{cwd}/.batman_config.json")
  catch e
    if e.code is "MODULE_NOT_FOUND"
      console.log "  --> NOT FOUND ./.batman_config.json"
      batmanConfig = {}
    else
      throw e
  batmanConfig
