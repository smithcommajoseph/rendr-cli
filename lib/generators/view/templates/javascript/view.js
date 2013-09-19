var BaseView = require('../base');

module.exports = BaseView.extend({
  className: '<%= name.underscored %>_<%= action.underscored %>_view'
});
module.exports.id = '<%= name.underscored %>/<%= action.underscored %>';
