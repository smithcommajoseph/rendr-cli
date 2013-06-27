var CollectionGenerator,
    BaseGenerator = require('../../base_generator'),
    fs = require('fs'),
    walk = require('walk');

CollectionGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    {'args[1]': { alias: 'modelName', required: true }},
    {'url': { required: false }},
    {'api': { required: false }}
  ],

  availableTplProps: ['url', 'api'],

  initialize: function() {
    BaseGenerator.prototype.initialize.call(this);
    // try to ensure we are pluralized
    this.opts.collectionName = this.pluralize(this.opts.modelName);
    var sfx = this.getFileSuffix();
    this.targetParent += '/app/collections/' + this.underscore(this.opts.collectionName) + '.' + sfx;
    this.hasCompanions = false;
  },

  preGenerate: function(next) {
    if (this.isFile(this.targetParent)) {
      this.logToConsole('warn', 'Collection' + this.opts.collectionName + ' appears to already exist');
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
        camelized: generator.capCamelize(generator.opts.collectionName),
      },
      modelName: {
        camelized: generator.capCamelize(generator.opts.modelName),
        underscored: generator.underscore(generator.opts.modelName)
      },
      props: props
    };
  },

  displayGenerateCopy: function() {
    this.logToConsole('success', 'generated ', 'collection ', this.opts.collectionName);
    console.log('');
    console.log('');
  }

});