var ViewGenerator,
    BaseGenerator = require('../base_generator'),
    fs = require('fs'),
    walk = require('walk');

ViewGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[1]': { alias: 'viewName', required: true }},
    {'noTemplates': {}},
    {'appName': { required: false}}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.apply(this, arguments);
    if (this.opts.appName) {
      this.targetParent += '/' + this.opts.appName;
      this.verbose = false;
    }
    if (!!this.opts.noTemplates ) this.hasCompanions = false;
    this.targetParent += '/app/views/' + this.underscore(this.opts.viewName);
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
        tpl,
        data,
        targetFile;

    walker.on('file', function (root, fileStats, next) {
      tpl = generator.compileTemplate( fs.readFileSync(root + '/' + fileStats.name, 'utf8') );
      generator.actions.forEach(function(action) {
        targetFile = generator.targetParent + '/' + generator.underscore(action) + '.' + generator.suffix;
        if( generator.isFile(targetFile) ) {
          generator.logToConsole('error', 'already exists', 'file', targetFile);
        } else {
          data = tpl( generator.getTemplateData(generator, action) );
          generator.createFile(targetFile, data);
        }
      });
    });
    walker.on('end',next);
  },

  getTemplateData: function(generator, action) {
    return {
      name: {
        underscored: generator.underscore(generator.opts.viewName),
      },
      action: {
        underscored: generator.underscore(action)
      }
    };
  },

  getCompanions: function() {
    return [
      {
        args: ['template', this.opts.viewName].concat(this.actions)
      }
    ];
  },

  displayGenerateCopy: function() {
    if (this.verbose) {
      this.logToConsole('success', 'generated ', 'view', this.opts.viewName);
      console.log('');
      console.log('');
    }
  }

});