var ModelGenerator,
    BaseGenerator = require('../../base_generator'),
    fs = require('fs'),
    walk = require('walk');

ModelGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[0]': { alias: 'modelName', required: true }},
    {'url': { required: false }},
    {'idAttribute': { required: false }},
    {'apiHost': { required: false }}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.call(this);
    var sfx = this.getFileSuffix();
    this.targetParent += '/app/models/' + this.opts.modelName + '.' + sfx;
  },

  preGenerate: function(next) {
    if (this.isFile(this.targetParent)) {
      this.logToConsole('warn', 'Model ' + this.opts.modelName + ' appears to already exist');
      return false;
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
    return {
      name: generator.opts.modelName,
      url: generator.opts.url,
      idAttribute: generator.opts.idAttribute,
      apiHost: generator.opts.apiHost
    };
  },

  displayCopy: function() {
    this.logToConsole('success', 'generated ', 'model', this.opts.modelName);
  }

});