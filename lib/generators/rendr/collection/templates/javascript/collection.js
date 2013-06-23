var Base = require('./base');
    <%= modelName.camelized %> = require('../models/<%= modelName.underscored %>');

module.exports = Base.extend({
  model: <%= modelName.camelized %><% if (props.length>0) { %>,
  <% } %><% props.forEach( function(prop, idx) { %><%= prop.name %>: '<%= prop.val %>'<% if (idx != props.length-1) { %>,
  <% } %><% }); %>
});
module.exports.id = '<%= name.camelized %>';