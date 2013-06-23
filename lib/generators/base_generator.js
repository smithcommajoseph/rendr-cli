var _ = require('underscore'),
    s = require('string'),
    i = require('i')(),
    fs = require('fs'),
    async = require('async'),
    colors = require('colors'),
    BaseGenerator,

    VALID_GENERATORS = ['app', 'model', 'collection', 'view', 'controller', 'template', 'scaffold'];

function noop() {}

BaseGenerator = function BaseGenerator(generatorDir, generatorName, args, opts, hasCompanions) {
  this.generatorDir   = generatorDir;
  this.generatorName  = generatorName;
  this.lang           = this.getLang(opts);
  this.tplEngine      = this.getTplEngine(opts);
  this.opts           = this.getGeneratorOpts(args, opts);
  this.args           = this.getGeneratorArgs(args);
  this.templates      = this.generatorDir + '/templates/' + this.lang;
  this.targetParent   = process.cwd();
  this.hasCompanions  = typeof hasCompanions === "undefined" ? true : hasCompanions;
  this.verbose        = true;

  this.initialize();
};

BaseGenerator.prototype.initialize = noop;

BaseGenerator.prototype.getGeneratorOpts = function(args, options) {
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
        opts[optName] = options[k] || args[ Number(argRegex.exec(k)[1]) ];
      }
      catch(err) { opts[optName] = undefined; }
      if (isRequired && !opts[optName]) throw new Error('Missing required Argument ' + optName);
    });

    return opts;
};

BaseGenerator.prototype.getGeneratorArgs = function(args) {
  return this.generatorName == "app" ? args.slice(1) : args.slice(2);
};

BaseGenerator.prototype.logToConsole = function(type, cmd, desc, deets) {
  var pre = 'rendr',
      copy;
  desc = !!desc ? desc.magenta : '';
  deets = deets || '';
  switch(type){
    case 'success':
      cmd = cmd.green;
      break;
    case 'error':
      cmd = cmd.red;
      break;
    case 'warn':
      cmd = cmd.yellow;
      break;
  }
  copy = [pre, cmd, desc, deets].join(' ');
  console.log(copy);
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

BaseGenerator.prototype.createDirectory = function(dir) {
  try{
    fs.mkdirSync(dir);
    if (this.verbose) this.logToConsole('success', 'generating', 'dir ', dir);
  }
  catch(err) {
    this.logToConsole('error', 'failed to generate', 'dir ', dir);
    console.log(err); //go ahead and give the full error
  }
};

BaseGenerator.prototype.createFile = function(file, data) {
  try{
    fs.writeFileSync(file, data);
    if (this.verbose) this.logToConsole('success', 'generating', 'file', file);
  }
  catch(err){
    this.logToConsole('error', 'failed to generate', 'file ', file);
    console.log(err); //go ahead and give the full error 
  }
};

BaseGenerator.prototype.compileTemplate = function(template) {
  return _.template(template);
};

BaseGenerator.prototype.generate = function() {
  async.series([
    this.preGenerate.bind(this),
    this.renderTemplates.bind(this),
    this.postGenerate.bind(this)
  ]);
};

// Ultimately, we could add other compiled languages, typescript, etc...
BaseGenerator.prototype.getLang = function(opts) {
  return (opts.coffee) ? 'coffeescript' : 'javascript';
};

// Ultimately, we could add other templating engines as well.
BaseGenerator.prototype.getTplEngine = function(opts) {
  return 'handlebars';
};

BaseGenerator.prototype.getFileSuffix = function() {
  var langSuffixMap = {
    'javascript': 'js',
    'coffeescript': 'coffee'
  };
  return langSuffixMap[this.lang];
};

BaseGenerator.prototype.getTemplateSuffix = function() {
  var tplSuffixMap = {
    'handlebars': 'hbs'
  };
  return tplSuffixMap[this.tplEngine];
};

BaseGenerator.prototype.getResourceActions = function() {
  var DEFAULT_ACTIONS = ['index'];
  return this.args.length > 0 ? this.args : DEFAULT_ACTIONS;
};

BaseGenerator.prototype.preGenerate = function(next) { next(); };

BaseGenerator.prototype.renderTemplates = function(next) { next(); };

BaseGenerator.prototype.postGenerate = function() {
  if (this.hasCompanions) {
    var companions = this.getCompanions();
    this.renderCompanions(companions);
  }
  this.displayCopy();
};

BaseGenerator.prototype.getTemplateData = noop;

BaseGenerator.prototype.getCompanions = noop;

BaseGenerator.prototype.renderCompanions = function(companions) {
  var generator;
  companions.forEach(function(companion){
    generator = BaseGenerator.getGenerator('generate', companion.args, companion, false);
    generator.generate();
  });
};

BaseGenerator.prototype.displayCopy = noop;

BaseGenerator.prototype.capitalize = function(str) {
  return s(str).capitalize().s;
};

BaseGenerator.prototype.camelize = function(str) {
  return s(str).humanize().slugify().camelize().s;
};

BaseGenerator.prototype.capCamelize = function(str) {
  return s(str).humanize().slugify().capitalize().camelize().s;
};

BaseGenerator.prototype.dasherize = function(str) {
  return s(str).humanize().slugify().s;
};

BaseGenerator.prototype.humanize = function(str) {
  return s(str).humanize().s;
};

BaseGenerator.prototype.underscore = function(str) {
  return s(this.camelize(str)).underscore().s;
};

BaseGenerator.prototype.pluralize = function(str) {
  return i.pluralize(str);
};

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
  child.prototype = new Surrogate();

  if (protoProps) _.extend(child.prototype, protoProps);

  child.__super__ = parent.prototype;

  return child;
};

BaseGenerator.getGenerator = function(cmd, args, opts, hasCompanions) {
  var generatorName = BaseGenerator.getGeneratorName(cmd, args),
      generatorDir = __dirname + '/rendr/' + generatorName,
      Generator = require(generatorDir + '/' + generatorName + '_generator');

  return new Generator(generatorDir, generatorName, args, opts, hasCompanions);
};

BaseGenerator.getGeneratorName = function(cmd, args) {
  var generatorName = ('new' == cmd) ? 'app' : args[0];
  return !!~VALID_GENERATORS.indexOf(generatorName) ? generatorName : undefined;
};

/*
 * Export it
 */

module.exports = BaseGenerator;
