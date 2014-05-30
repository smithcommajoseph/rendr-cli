var ModelGenerator,
    BaseGenerator = require('../base_generator'),
    fs = require('fs'),
    walk = require('walk');

ModelGenerator = module.exports = BaseGenerator.extend({

  validOpts: [
    {'args[1]': { alias: 'modelName', required: true }},
    {'url': { required: false }},
    {'idAttribute': { required: false }},
    {'api': { required: false }},
    {'addCollection': {}}
  ],

  availableTplProps: ['url', 'idAttribute', 'api'],

  initialize: function() {
    BaseGenerator.prototype.initialize.apply(this, arguments);
    this.targetParent += '/app/models/' + this.underscore(this.opts.modelName) + '.' + this.suffix;
    this.hasCompanions = !!this.opts.addCollection || false;
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
        walker,
        tpl,
        data;

    walker = walk.walkSync(this.templates, {
      listeners: {
        file: function (root, fileStats, next) {
          tpl = generator.compileTemplate( fs.readFileSync(root + '/' + fileStats.name, 'utf8') );
          data = tpl( generator.getTemplateData(generator) );
          generator.createFile(generator.targetParent, data);
        },
        end: next
      }
    });
  },

  getTemplateData: function(generator) {
    var availableProps = generator.availableTplProps,
        props = [],
        _tmp;

    for (var i=0, len = availableProps.length; i<len; i++) {
      if ( typeof (_tmp = generator.opts[availableProps[i]]) != "undefined" ) {
        props.push({name: availableProps[i], val: _tmp});
      }
    }

    return {
      name: {
        camelized: generator.capCamelize(generator.opts.modelName),
      },
      props: props
    };
  },

  getCompanions: function() {
    return [
      {
        args: ['collection', this.opts.modelName],
        url: this.opts.url,
        api: this.opts.api
      }
    ];
  },

  displayGenerateCopy: function() {
    this.logToConsole('success', 'generated ', 'model', this.opts.modelName);
    console.log('');
    console.log('');
  }

});