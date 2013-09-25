Base = require("./base")
module.exports = Base.extend(<% if (props.length === 0) { %>)<% } else { %><% props.forEach( function(prop, idx) { %>
  <%= prop.name %>: '<%= prop.val %>'<% }); %>
)<% } %>
module.exports.id = '<%= name.camelized %>'