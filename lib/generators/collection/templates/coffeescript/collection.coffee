Base = require("./base")
<%= modelName.camelized %> = require('../models/<%= modelName.underscored %>')
module.exports = Base.extend(
  model: <%= modelName.camelized %><% props.forEach( function(prop, idx) { %>
  <%= prop.name %>: '<%= prop.val %>'<% }); %>
)
module.exports.id = '<%= name.camelized %>'