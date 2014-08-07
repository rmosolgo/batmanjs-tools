argv = require('minimist')(process.argv.slice(2));
Generator = require("../generator/generator")
loadConfig = require("./load_config")

class CLI
  run: (config) ->
    config ?= loadConfig()
    cmd = argv._.shift()

    for own key, val of config
      argv[key] ||= config[key]

    if cmd in ["generate", "g"]
      generator = new Generator(argv)
      generator.dispatch()

    else if cmd is "new"
      # generate a new project
      argv._.unshift("project")
      generator = new Generator(argv)
      generator.dispatch()

    else
      console.error "Unrecognized command: #{cmd}"

module.exports = new CLI