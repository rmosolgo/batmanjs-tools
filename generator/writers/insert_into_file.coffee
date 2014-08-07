fs = require 'fs'

module.exports = (file, newContent, options={}) ->
  existingContent = fs.readFileSync(file).toString()

  if options.before
    finalContent = existingContent.replace(options.before, newContent + "$&")
  else if options.after
    finalContent = existingContent.replace(options.after, "$&" + newContent)
  else
    throw "You must specify before or after regexp!"

  fs.writeFileSync(file, finalContent)

