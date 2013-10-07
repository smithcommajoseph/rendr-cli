###
We inject the Handlebars instance, because this module doesn't know where
the actual Handlebars instance will come from.
###
module.exports = (Handlebars) ->
  copyright: (year) ->
    new Handlebars.SafeString("&copy;" + year)
