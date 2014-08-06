argv = require('minimist')(process.argv.slice(2));
Generator = require("../generator/generator")


class CLI
  run: (config={}) ->
    cmd = argv._.shift()
    argv.appName ||= config.appName
    argv.appRoot ||= config.appRoot

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