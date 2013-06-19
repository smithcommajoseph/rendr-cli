var ScaffoldGenerator,
    BaseGenerator = require('../../base_generator'),
    fs = require('fs'),
    walk = require('walk');

ScaffoldGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[0]': { alias: 'scaffoldName', required: true }}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.call(this);
    this.actions = this.getResourceActions();
  },

  getCompanions: function() {
    return [
      {
        generate: 'view',
        args: [this.opts.scaffoldName].concat(this.actions)
      },
      {
        generate: 'controller',
        args: [this.opts.scaffoldName].concat(this.actions)
      },
      {
        generate: 'template',
        args: [this.opts.scaffoldName].concat(this.actions)
      }
    ];
  }

});