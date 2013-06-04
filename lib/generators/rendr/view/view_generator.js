var ViewGenerator,
    BaseGenerator = require('../../base_generator'),
    fs = require('fs'),
    walk = require('walk'),
    Handlebars = require('handlebars'),

    DEFAULT_ACTIONS = ['index'];

ViewGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[0]': { alias: 'viewName', required: true }}
  ],

  preGenerate: function() {
    this.targetParent = this.targetParent + '/app/views/' + this.opts.viewName;
    this.actions = this.getActions();
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
        data = tpl({name: generator.opts.viewName, action: action});
        fs.writeFileSync(generator.targetParent + '/' + action + '.' + sfx, data);
      });
    });
  },

  renderCompanions: function() {
    // render controller
    // render templates
  },

  getActions: function() {
    return this.args.length > 0 ? this.args : DEFAULT_ACTIONS;
  }

});