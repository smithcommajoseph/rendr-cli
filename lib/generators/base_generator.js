var fs = require('fs'),
    walk = require('walk'),
    async = require('async'),
    BaseGenerator,
    _ = require('underscore'),

    VALID_GENERATORS = ['app', 'model', 'view', 'controller', 'scaffold'];

function noop() {}

BaseGenerator = function BaseGenerator(generatorDir, generatorName, options, hasCompanions) {
  this.generatorDir = generatorDir;
  this.generatorName = generatorName;
  this.lang = BaseGenerator.getLang(options);
  this.opts = this.getGeneratorOpts(options);
  this.args = this.getGeneratorArgs(options.args);
  this.templates = this.generatorDir + '/templates/' + this.lang;
  this.targetParent = process.cwd();
  this.hasCompanions = typeof hasCompanions === "undefined" ? true : hasCompanions;
  this.initialize();
};

BaseGenerator.prototype.initialize = noop;

BaseGenerator.prototype.getGeneratorOpts = function(options) {
    var k,
        optName,
        isRequired,
        keys = Object.keys,
        argRegex = /args\[(\d*)\]/,
        opts = {};

    this.validOpts.forEach(function(validOpt){
      k = keys(validOpt)[0];
      optName = validOpt[k].alias || k;
      isRequired = validOpt[k].required || false;
      try{
        opts[optName] = options[k] || options.args[ Number(argRegex.exec(k)[1]) ];
        opts[optName] = opts[optName].toLowerCase();
      }
      catch(err) { /*let opts[optName] be undefined*/}
      if (isRequired && !opts[optName]) throw new Error('Missing required Argument ' + optName);
    });

    return opts;
};

BaseGenerator.prototype.getGeneratorArgs = function(args) {
    return args.slice(1);
};

BaseGenerator.prototype.dirExists = function(dir) {
  var retVal = false;
  try { fs.statSync(dir).isDirectory(); retVal = true;}
  catch (er) { }
  return retVal;
};

BaseGenerator.prototype.isFile = function(dir) {
  var retVal = false;
  try { fs.statSync(dir).isFile(); retVal = true;}
  catch (er) { }
  return retVal;
};

BaseGenerator.prototype.createDirectory = function(dir, verbose) {
  if (!!verbose) console.log('creating directory ' + dir);
  fs.mkdirSync(dir);  
};

BaseGenerator.prototype.generate = function() {
  async.series([
    this.preGenerate.bind(this),
    this.renderTemplates.bind(this),
    this.postGenerate.bind(this)
  ]);
};

BaseGenerator.prototype.getFileSuffix = function() {
  var langSuffixMap = {
    'javascript': 'js',
    'coffeescript': 'coffee'
  };

  return langSuffixMap[this.lang];
};

BaseGenerator.prototype.getResourceActions = function() {
  var DEFAULT_ACTIONS = ['index'];
  return this.args.length > 0 ? this.args : DEFAULT_ACTIONS;
};

BaseGenerator.prototype.preGenerate = function(next) { next(); };

BaseGenerator.prototype.renderTemplates = function(next) { next(); };

BaseGenerator.prototype.postGenerate = function() {
  if (this.hasCompanions) this.renderCompanions();
};

BaseGenerator.prototype.getTemplateData = noop;

BaseGenerator.prototype.renderCompanions = noop;

/*
 * Class methods
 */

BaseGenerator.extend = function(protoProps, staticProps) {
  var parent = this;
  var child;

  if (protoProps && _.has(protoProps, 'constructor')) {
    child = protoProps.constructor;
  } else {
    child = function(){ return parent.apply(this, arguments); };
  }

  _.extend(child, parent, staticProps);

  var Surrogate = function(){ this.constructor = child; };
  Surrogate.prototype = parent.prototype;
  child.prototype = new Surrogate;

  if (protoProps) _.extend(child.prototype, protoProps);

  child.__super__ = parent.prototype;

  return child;
};

BaseGenerator.getGenerator = function(cli, hasCompanions) {
  var generatorName = BaseGenerator.getGeneratorName(cli),
      generatorDir = __dirname + '/rendr/' + generatorName,
      Generator = require(generatorDir + '/' + generatorName + '_generator');

  return new Generator(generatorDir, generatorName, cli, hasCompanions);
};

BaseGenerator.getGeneratorName = function(opts) {
  var generatorName;

  if (opts.new) {
    generatorName = 'app';
  }
  else if (opts.generate) {
    generatorName = opts.generate;
  }

  return !!~VALID_GENERATORS.indexOf(generatorName) ? generatorName : undefined;
};

// Ultimately, we could add other compiled languages, typescript, etc...
BaseGenerator.getLang = function(opts) {
  return (opts.coffee) ? 'coffeescript' : 'javascript';
};


/*
 * Export it
 */

module.exports = BaseGenerator;
