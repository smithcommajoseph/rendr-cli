var ScaffoldGenerator,
    BaseGenerator = require('../base_generator');

ScaffoldGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[1]': { alias: 'scaffoldName', required: true }}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.apply(this, arguments);
    this.actions = this.getResourceActions();
  },

  getCompanions: function() {
    return [
      {
        args: ['view', this.opts.scaffoldName].concat(this.actions)
      },
      {
        args: ['controller', this.opts.scaffoldName].concat(this.actions)
      },
      {
        args: ['template', this.opts.scaffoldName].concat(this.actions)
      }
    ];
  }

});