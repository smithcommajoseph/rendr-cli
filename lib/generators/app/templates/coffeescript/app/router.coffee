BaseClientRouter = require("rendr/client/router")
Router = module.exports = Router = (options) ->
  BaseClientRouter.call this, options

Router::__proto__ = BaseClientRouter::
Router::postInitialize = ->
  @on "action:start", @trackImpression, this

Router::trackImpression = ->
  _gaq.push ["_trackPageview"]  if window._gaq
