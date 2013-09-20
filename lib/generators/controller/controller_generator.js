var ControllerGenerator,
    BaseGenerator = require('../base_generator'),
    fs = require('fs'),
    walk = require('walk');

ControllerGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[1]': { alias: 'controllerName', required: true }},
    {'appName': { required: false}}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.apply(this, arguments);
    var sfx = this.getFileSuffix();
    if (this.opts.appName) {
      this.targetParent += '/' + this.opts.appName;
      this.verbose = false;
    }
    this.targetParent += '/app/controllers/' + this.underscore(this.opts.controllerName) + '_controller.' + sfx;
    this.actions = this.getResourceActions();
    this.existingActions = {};
    this.hasCompanions = false;
  },

  preGenerate: function(next) {
    var generator = this,
        f,
        existings,
        idx;

    if (this.isFile(this.targetParent)) {
      f = require(this.targetParent);
      existings = Object.keys(f);

      //keep the existing order
      for(var i=existings.length-1; i>=0; i--){
        if( (idx = generator.actions.indexOf(existings[i])) != -1 ) { generator.actions.splice(idx, 1); }
        generator.actions.unshift(existings[i]);
        generator.existingActions[existings[i]] = f[existings[i]].toString();
      }

    }
    next();
  },

  renderTemplates: function(next) {
    var generator = this,
        walker = walk.walkSync(this.templates, {}),
        tpl,
        data;

    walker.on('file', function (root, fileStats, next) {
      tpl = generator.compileTemplate( fs.readFileSync(root + '/' + fileStats.name, 'utf8') );
      data = tpl( generator.getTemplateData(generator) );
      generator.createFile(generator.targetParent, data);
    });
    walker.on('end', next);
  },

  getTemplateData: function(generator) {
    var tplData = {},
        actionOb;

    tplData.actions = [];
    tplData.name = {
      underscored: generator.underscore(generator.opts.controllerName)
    };

    generator.actions.forEach(function(action){
      actionOb = {
        name: {
          underscored: generator.underscore(action)
        }
      };
      if (!!generator.existingActions[action]) { actionOb.existing = generator.existingActions[action]; }
      tplData.actions.push(actionOb);
    });

    return tplData;
  },

  displayGenerateCopy: function() {
    if (this.verbose) {
      this.logToConsole('success', 'generated ', 'controller', this.opts.controllerName);
      console.log('');
      console.log('');
    }
  }

});