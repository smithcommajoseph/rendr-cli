express = require("express")
notFoundHandler = require("rendr/server/middleware/notFoundHandler")

#
# This is the error handler used with Rendr routes.
#
module.exports = ->
  errorHandler = (err, req, res, next) ->
    if err.status is 401
      res.redirect "/login"
    else if err.status is 404
      notFoundHandler() req, res, next
    else
      express.errorHandler() err, req, res, next
