var ViewGenerator,
    BaseGenerator = require('../../base_generator'),
    fs = require('fs'),
    walk = require('walk');

ViewGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[0]': { alias: 'viewName', required: true }},
    {'noTemplates': {}},
    {'appName': { required: false}}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.call(this);
    if (this.opts.appName) {
      this.targetParent += '/' + this.opts.appName;
      this.verbose = false;
    }
    if (!!this.opts.noTemplates ) this.hasCompanions = false;
    this.targetParent += '/app/views/' + this.opts.viewName;
    this.actions = this.getResourceActions();
  },

  preGenerate: function(next) {
    if (!this.dirExists(this.targetParent)) {
      this.createDirectory(this.targetParent);
    }
    next();
  },

  renderTemplates: function(next) {
    var generator = this,
        walker = walk.walkSync(this.templates, {}),
        sfx = generator.getFileSuffix(),
        tpl,
        data,
        targetFile;

    walker.on('file', function (root, fileStats, next) {
      tpl = generator.compileTemplate( fs.readFileSync(root + '/' + fileStats.name, 'utf8') );
      generator.actions.forEach(function(action) {
        targetFile = generator.targetParent + '/' + action + '.' + sfx;
        if( generator.isFile(targetFile) ) {
          generator.logToConsole('error', 'already exists', 'file', targetFile);
        } else {
          data = tpl( generator.getTemplateData(generator, action) );
          generator.createFile(generator.targetParent + '/' + action + '.' + sfx, data);
        }
      });
    });
    walker.on('end',next);
  },

  getTemplateData: function(generator, action) {
    return {name: generator.opts.viewName, action: action};
  },

  getCompanions: function() {
    return [
      {
        generate: 'template',
        args: [this.opts.viewName].concat(this.actions)
      }
    ];
  },

  displayCopy: function() {
    if (this.verbose) {
      this.logToConsole('success', 'generated ', 'view', this.opts.viewName);
      console.log('');
      console.log('');
    }
  }

});