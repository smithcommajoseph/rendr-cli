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

  preGenerate: function(next) {
    var sfx = this.getFileSuffix();
    if (this.dirExists(this.targetParent + '/app/views/' + this.opts.scaffoldName)) {
      this.logToConsole('warn', 'View ' + this.opts.scaffoldName + ' appears to already exist');
      return false;
    }
    if (this.dirExists(this.targetParent + '/app/controllers/' + this.opts.scaffoldName + '_controller.' + sfx)) {
      this.logToConsole('warn', 'Controller ' + this.opts.scaffoldName + ' appears to already exist');
      return false;
    }
    next();
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