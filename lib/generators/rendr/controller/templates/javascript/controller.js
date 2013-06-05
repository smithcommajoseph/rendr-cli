module.exports = {
{{#foreach actions}}
  {{action}}: function(params, callback) {
    {{#if hasData}}
    var spec = {
      {{#if model}}
      model: { model: '{{model}}', params: params }
      {{/if}}
      {{#if collection}}
      collection: { collection: '{{collection}}', params: params }
      {{/if}}
    };
    this.app.fetch(spec, function (err, result) {
      callback(err, '{{../../name}}/{{action}}', result);
    });
    {{else}}callback(null, '{{../../name}}/{{action}}');{{/if}}
  }{{#if $last}}{{else}},{{/if}}
{{/foreach}}
};