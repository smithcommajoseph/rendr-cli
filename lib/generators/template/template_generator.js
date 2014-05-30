var TemplateGenerator,
    BaseGenerator = require('../base_generator'),
    fs = require('fs'),
    walk = require('walk');

TemplateGenerator = module.exports = BaseGenerator.extend({

  validOpts: [
    {'args[1]': { alias: 'templateName', required: true }},
    {'appName': { required: false}}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.apply(this, arguments);
    if (this.opts.appName) this.targetParent += '/' + this.opts.appName;
    this.targetParent += '/app/templates/' + this.underscore(this.opts.templateName);
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
        walker,
        sfx = generator.getTemplateSuffix(),
        tpl,
        data,
        targetFile;

    walker = walk.walkSync(this.templates, {
      listeners: {
        file: function (root, fileStats, next) {
          tpl = generator.compileTemplate(fs.readFileSync(root + '/' + fileStats.name, 'utf8'));
          generator.actions.forEach(function(action) {
            targetFile = generator.targetParent + '/' + generator.underscore(action) + '.' + sfx;
            if( generator.isFile(targetFile) ) {
              generator.logToConsole('error', 'already exists', 'file', targetFile);
            } else {
              data = tpl( generator.getTemplateData(generator, action, targetFile) );
              fs.writeFileSync(targetFile, data);
            }
          });
        },
        end: next
      }
    });
  },

  getTemplateData: function(generator, action, path) {
    return {
      name: generator.opts.templateName,
      action: action,
      path: path
    };
  }

});