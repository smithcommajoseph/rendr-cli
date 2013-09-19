module.exports = {
<% actions.forEach( function(action, idx) { %>
  <%= action.name.underscored %>: <% if(action.existing) { %><%= action.existing %><% } else { %>function(params, callback) {
    <% if (typeof action.hasData != "undefined") { %>
    var spec = {
      <% if (typeof action.model != "undefined") { %>
      model: { model: '<%= action.model.capitalized %>', params: params }
      <% } %>
      <% if (typeof action.collection != "undefined") { %>
      collection: { collection: '<%= action.collection.capitalized %>', params: params }
      <% } %>
    };
    this.app.fetch(spec, function (err, result) {
      callback(err, result);
    });
    <% } else { %>
    callback();
    <% } %>
  }<% } %><% if (idx != actions.length-1) { %>,<% } %>
<% }); %>
};