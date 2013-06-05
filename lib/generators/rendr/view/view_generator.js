var ViewGenerator,
    BaseGenerator = require('../../base_generator'),
    // ControllerGenerator = require('../controller/controller_generator'),
    // TemplateGenerator = require('../template/template_generator'),
    fs = require('fs'),
    walk = require('walk'),
    Handlebars = require('../../handlebars');

ViewGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[0]': { alias: 'viewName', required: true }}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.call(this);
    this.targetParent = this.targetParent + '/app/views/' + this.opts.viewName;
    this.actions = this.getResourceActions();
  },

  preGenerate: function() {
    if (this.dirExists(this.targetParent)) {
      console.log('View ' + this.opts.viewName + ' appears to already exist');
      return false;
    }
    this.createDirectory(this.targetParent, true);
  },

  renderTemplates: function() {
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
  },

  getTemplateData: function(generator, action) {
    return {name: generator.opts.viewName, action: action};
  },

  renderCompanions: function() {
    // render controller
    // render templates
  }

});