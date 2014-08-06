ECT = require('ect');
renderer = ECT({ watch: true, root: __dirname + "/templates", ext : '.ect' });
mkdirp = require 'mkdirp'
fs    = require 'fs'
path  = require 'path'

writeTemplate = (templateName, data, destination) ->
  code = renderer.render(templateName, data);
  if destination?
    dir = path.dirname(destination)
    if !fs.existsSync(dir)
      mkdirp.sync(dir)
      console.log "  --> CREATE DIRECTORY #{dir}"
    fs.writeFileSync(destination, code)
    console.log "  --> CREATE #{destination}"
  code

module.exports = writeTemplate