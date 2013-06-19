module.exports = {
<% actions.forEach( function(action, idx) { %>
  <%= action.name %>: <% if(action.existing) { %><%= action.existing %><% } else { %>function(params, callback) {
    <% if (typeof action.hasData != "undefined") { %>
    var spec = {
      <% if (typeof action.model != "undefined") { %>
      model: { model: '<%= action.model %>', params: params }
      <% } %>
      <% if (typeof action.collection != "undefined") { %>
      collection: { collection: '<%= action.collection %>', params: params }
      <% } %>
    };
    this.app.fetch(spec, function (err, result) {
      callback(err, '<%= name %>/<%= action.name %>', result);
    });
    <% } else { %>
    callback(null, '<%= name %>/<%= action.name %>');
    <% } %>
  }<% } %><% if (idx != actions.length-1) { %>,<% } %>
<% }); %>
};