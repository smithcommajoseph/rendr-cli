var BaseView = require('../base');

module.exports = BaseView.extend({
  className: '{{name}}_{{action}}_view'
});
module.exports.id = '{{name}}/{{action}}';
