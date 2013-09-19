var Base = require('./base');

module.exports = Base.extend({
  <% props.forEach( function(prop, idx) { %><%= prop.name %>: '<%= prop.val %>'<% if (idx != props.length-1) { %>,
  <% } %><% }); %>
});
module.exports.id = '<%= name.camelized %>';