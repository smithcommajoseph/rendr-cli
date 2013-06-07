var TemplateGenerator,
    BaseGenerator = require('../../base_generator'),
    fs = require('fs'),
    walk = require('walk'),
    _ = require('underscore');

TemplateGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[0]': { alias: 'templateName', required: true }},
    {'appName': { required: false}}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.call(this);
    if (this.opts.appName) this.targetParent += '/' + this.opts.appName;
    this.targetParent += '/app/templates/' + this.opts.templateName;
    this.actions = this.getResourceActions();
  },

  preGenerate: function(next) {
    if (this.dirExists(this.targetParent)) {
      console.log('Template ' + this.opts.templateName + ' appears to already exist');
      return false;
    }
    this.createDirectory(this.targetParent, true);
    next();
  },

  renderTemplates: function(next) {
    var generator = this,
        walker = walk.walkSync(this.templates, {}),
        sfx = generator.getTemplateSuffix(),
        tpl,
        data,
        targetFile;

    walker.on('file', function (root, fileStats, next) {
      tpl = _.template(fs.readFileSync(root + '/' + fileStats.name, 'utf8'));
      generator.actions.forEach(function(action) {
        targetFile = generator.targetParent + '/' + action + '.' + sfx;
        data = tpl( generator.getTemplateData(generator, action, targetFile) );
        fs.writeFileSync(targetFile, data);
      });
    });
    walker.on('end',next);
  },

  getTemplateData: function(generator, action, path) {
    return {name: generator.opts.templateName, action: action, path: path};
  },

  renderCompanions: function() {
    // render controller
    // render templates
  }

});