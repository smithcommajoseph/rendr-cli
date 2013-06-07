var Base = require('./base');

module.exports = Base.extend({
  url: '<% if (typeof url != "undefined") { %><%= url %><% } %>',
  idAttribute: '<% if (typeof idAttribute != "undefined") { %><%= idAttribute %><% } %>'<% if (typeof apiHost != "undefined") { %>,
  apiHost: '<%= apiHost %>'<% } %>
});
module.exports.id = '<%= name %>';