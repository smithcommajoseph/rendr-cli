BaseApp = require("rendr/shared/app")

# @client
module.exports = BaseApp.extend(start: ->
  
  # Show a loading indicator when the app is fetching.
  @router.on "action:start", (->
    @set loading: true
  ), this
  @router.on "action:end", (->
    @set loading: false
  ), this
  
  # Call 'super'.
  BaseApp::start.call this
)
