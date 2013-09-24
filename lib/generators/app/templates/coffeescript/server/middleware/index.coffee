fs = require("fs")
path = require("path")
fs.readdirSync(__dirname).forEach (filename) ->
  name = undefined
  name = path.basename(filename, ".js")
  return  if name is "index" or name[0] is "_"
  exports.__defineGetter__ name, ->
    require "./" + name


