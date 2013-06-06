var ViewGenerator,
    BaseGenerator = require('../../base_generator'),
    // ControllerGenerator = require('../controller/controller_generator'),
    // TemplateGenerator = require('../template/template_generator'),
    fs = require('fs'),
    walk = require('walk'),
    Handlebars = require('../../handlebars');

ViewGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[0]': { alias: 'viewName', required: true }},
    {'appName': { required: false}}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.call(this);
    if (this.opts.appName) this.targetParent += '/' + this.opts.appName;
    this.targetParent += '/app/views/' + this.opts.viewName;
    this.actions = this.getResourceActions();
  },

  preGenerate: function(next) {
    if (this.dirExists(this.targetParent)) {
      console.log('View ' + this.opts.viewName + ' appears to already exist');
      return false;
    }
    this.createDirectory(this.targetParent, true);
    next();
  },

  renderTemplates: function(next) {
    var generator = this,
        walker = walk.walkSync(this.templates, {}),
        sfx = generator.getFileSuffix(),
        tpl,
        data;

    walker.on('file', function (root, fileStats, next) {
      tpl = Handlebars.compile(fs.readFileSync(root + '/' + fileStats.name, 'utf8'));
      generator.actions.forEach(function(action) {
        data = tpl( generator.getTemplateData(generator, action) );
        fs.writeFileSync(generator.targetParent + '/' + action + '.' + sfx, data);
      });
    });
    walker.on('end',next);
  },

  getTemplateData: function(generator, action) {
    return {name: generator.opts.viewName, action: action};
  },

  renderCompanions: function(next) {
    // render controller
    // render templates

    next();
  }

});