/*jshint strict:false */

var server = require('./server/server'),
    config = require('config');

var port = process.env.PORT || config.App.port;

server.init(function(err) {
  if (err) throw err;
  server.start({port: port});
});