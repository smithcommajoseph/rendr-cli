DataAdapter = (options) ->
  @options = options or {}
utils = require("rendr/server/utils")
_ = require("underscore")
url = require("url")
request = require("request")
debug = require("debug")("app:DataAdapter")
inspect = require("util").inspect
module.exports = DataAdapter

#
# `req`: Actual request object from Express/Connect.
# `api`: Object describing API call; properties including 'path', 'query', etc.
#        Passed to `url.format()`.
# `options`: (optional) Options.
# `callback`: Callback.
#
DataAdapter::request = (req, api, options, callback) ->
  _this = this
  start = undefined
  end = undefined
  if arguments_.length is 3
    callback = options
    options = {}
  options = _.clone(options)
  _.defaults options,
    convertErrorCode: true
    allow4xx: false

  api = @apiDefaults(api)
  start = new Date().getTime()
  request api, (err, response, body) ->
    return callback(err)  if err
    end = new Date().getTime()
    debug "%s %s %s %sms", api.method.toUpperCase(), api.url, response.statusCode, end - start
    debug "%s", inspect(response.headers)
    if options.convertErrorCode
      err = _this.getErrForResponse(response,
        allow4xx: options.allow4xx
      )
    if typeof body is "string" and ~(response.headers["content-type"] or "").indexOf("application/json")
      try
        body = JSON.parse(body)
      catch e
        err = e
    callback err, response, body


DataAdapter::apiDefaults = (api) ->
  urlOpts = undefined
  basicAuth = undefined
  authParts = undefined
  apiHost = undefined
  api = _.clone(api)
  
  # If path contains a protocol, assume it's a URL.
  if api.path and ~api.path.indexOf("://")
    api.url = api.path
    delete api.path
  
  # Can specify a particular API to use, falling back to default.
  apiHost = @options[api.api] or @options["default"] or @options or {}
  urlOpts = _.defaults(_.pick(api, "protocol", "port", "query"), _.pick(apiHost, ["protocol", "port", "host"]))
  urlOpts.pathname = api.path or api.pathname
  api = _.defaults(api,
    method: "GET"
    url: url.format(urlOpts)
    headers: {}
  )
  
  # Add a custom UserAgent
  api.headers["User-Agent"] = "Rendr Api Proxy; Node.js"  unless api.headers["User-Agent"]?
  api.json = api.body  if api.body?
  basicAuth = process.env.BASIC_AUTH
  if basicAuth?
    authParts = basicAuth.split(":")
    api.auth =
      username: authParts[0]
      password: authParts[1]
      sendImmediately: true
  api


# Convert 4xx, 5xx responses to be errors.
DataAdapter::getErrForResponse = (res, options) ->
  status = undefined
  err = undefined
  status = +res.statusCode
  err = null
  if utils.isErrorStatus(status, options)
    err = new Error(status + " status")
    err.status = status
    err.body = res.body
  err
