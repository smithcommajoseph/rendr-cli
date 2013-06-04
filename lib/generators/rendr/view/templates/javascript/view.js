var BaseView = require('../base_view');

module.exports = BaseView.extend({
  className: '{{name}}_{{action}}_view'
});
module.exports.id = '{{name}}/{{action}}';
