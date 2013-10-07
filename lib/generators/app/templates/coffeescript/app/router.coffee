BaseClientRouter = require("rendr/client/router")
Router = module.exports = Router = (options) ->
  BaseClientRouter.call this, options


###
Cross-platform inheritance, taking advantage of `es5shim` for IE.
###
Router:: = Object.create(BaseClientRouter::)
Router::constructor = BaseClientRouter
Router::postInitialize = ->
  @on "action:start", @trackImpression, this

Router::trackImpression = ->
  _gaq.push ["_trackPageview"]  if window._gaq
