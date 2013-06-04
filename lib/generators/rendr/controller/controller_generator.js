var ControllerGenerator,
    BaseGenerator = require('../../base_generator'),
    // ViewGenerator = require('../view/view_generator'),
    // TemplateGenerator = require('../template/template_generator'),
    fs = require('fs'),
    walk = require('walk'),
    Handlebars = require('handlebars');

ControllerGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[0]': { alias: 'controllerName', required: true }}
  ],

  targetParent: this.targetParent + '/app/controllers/' + this.opts.controllerName,

  actions: this.getResourceActions(),

  preGenerate: function() {
    if (this.dirExists(this.targetParent)) {
      console.log('Controller ' + this.opts.controllerName + ' appears to already exist');
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
        data = tpl(getTemplateData(generator, action));
        fs.writeFileSync(generator.targetParent + '/' + action + '.' + sfx, data);
      });
    });
  },

  getTemplateData: function(generator, action) {
    return {name: generator.opts.controllerName, action: action};
  },
  
  renderCompanions: function() {
    // render views
    // render templates
  }

});