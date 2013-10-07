DataAdapter = (options) ->
  RestAdapter.call this, options
RestAdapter = require("rendr/server/data_adapter/rest_adapter")
util = require("util")
module.exports = DataAdapter
util.inherits DataAdapter, RestAdapter

###
We have to do a kind of silly thing for our example app; GitHub rate limits
requests to its API, but it ups the limit by an order of magnitude if
the request is authenticated using HTTP Basic Authentication.

We simply override the `apiDefaults` method, tacking on an `auth` property
if the `BASIC_AUTH` environment variable is present.
###
DataAdapter::apiDefaults = (api) ->
  basicAuth = undefined
  authParts = undefined
  api = RestAdapter::apiDefaults.call(this, api)
  basicAuth = process.env.BASIC_AUTH
  if basicAuth?
    authParts = basicAuth.split(":")
    api.auth =
      username: authParts[0]
      password: authParts[1]
      sendImmediately: true
  api
