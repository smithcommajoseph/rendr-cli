var _ = require('underscore'),
    fs = require('fs'),
    async = require('async'),
    colors = require('colors'),
    extend = require('./utilites/extend'),
    str = require('./utilites/string_formatters'),
    fileSys = require('./utilites/file_system'),
    BaseGenerator,

    VALID_GENERATORS = ['app', 'model', 'collection', 'view', 'controller', 'template', 'scaffold'];

function noop() {}
function passThrough(next) { next(); }

BaseGenerator = function BaseGenerator(generatorDir, generatorName, args, opts, hasCompanions) {
  this.generatorDir   = generatorDir;
  this.generatorName  = generatorName;
  this.program        = opts; //hold on to a ref of the cli program itself
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
        opts = {},
        generator = this;

    this.validOpts.forEach(function(validOpt){
      k = keys(validOpt)[0];
      optName = validOpt[k].alias || k;
      isRequired = validOpt[k].required || false;
      try{
        opts[optName] = options[k] || args[ Number(argRegex.exec(k)[1]) ];
      }
      catch(err) { opts[optName] = undefined; }
      if (isRequired && !opts[optName]) generator.throwError('generator.' + this.generatorName, 'Missing ' + optName);
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
      cmd = cmd.red.inverse;
      break;
    case 'warn':
      cmd = cmd.yellow;
      break;
  }
  copy = [pre, cmd, desc, deets].join(' ');
  console.log(copy);
};

// not really a 'throw', but does kill the process w/ a readable err message
BaseGenerator.prototype.throwError = function(desc, deets) {
  this.logToConsole('error', 'err', desc, deets);
  process.exit();
}

BaseGenerator.prototype.dirExists = fileSys.dirExists;

BaseGenerator.prototype.isFile = fileSys.isFile;

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

BaseGenerator.prototype.new = function() {
  this.generate();
};

BaseGenerator.prototype.destroy = function() {
  async.series([
    this.preDestroy.bind(this),
    this.deleteTemplates.bind(this),
    this.postDestroy.bind(this)
  ]);
};

// Ultimately, we could add other compiled languages, typescript, etc...
BaseGenerator.prototype.getLang = function(opts) {
  return (opts.coffee) ? 'coffeescript' : 'javascript';
};

// Ultimately, we could add other templating engines as well once they are supported by Rendr
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

BaseGenerator.prototype.getCompanions = noop;

// generate fns
BaseGenerator.prototype.preGenerate = passThrough;

BaseGenerator.prototype.renderTemplates = passThrough;

BaseGenerator.prototype.postGenerate = function() {
  if (this.hasCompanions) {
    var companions = this.getCompanions();
    this.renderCompanions(companions);
  }
  this.displayGenerateCopy();
};

BaseGenerator.prototype.getTemplateData = noop;

BaseGenerator.prototype.renderCompanions = function(companions) {
  var generator;
  companions.forEach(function(companion){
    generator = BaseGenerator.getGenerator('generate', companion.args, companion, false);
    generator.generate();
  });
};

BaseGenerator.prototype.displayGenerateCopy = noop;

// destroy fns
BaseGenerator.prototype.preDestroy = function(next) {
  var generator = this;
  this.program.confirm('This will destroy ' + this.generatorName.underline + ' ' + this.opts[this.generatorName+'Name'].bold + '. You good with that? (y/n) ', function(ok){
    if (!ok) {
      generator.logToConsole('warn', 'destroy canceled');
      process.exit();
    }
    else next();
  });
};

BaseGenerator.prototype.deleteTemplates = passThrough;

BaseGenerator.prototype.postDestroy = function() {
  if (this.hasCompanions) {
    var companions = this.getCompanions();
    this.destroyCompanions(companions);
  }
  this.displayDestroyCopy();
  process.exit(); // explicit exit
};

BaseGenerator.prototype.destroyCompanions = function(companions) {
  var generator;
  companions.forEach(function(companion){
    generator = BaseGenerator.getGenerator('destroy', companion.args, companion, false);
    generator.destroy();
  });
};

BaseGenerator.prototype.displayDestroyCopy = noop;

/*
 * Str fns
 */

BaseGenerator.prototype.capitalize = str.capitalize;
BaseGenerator.prototype.camelize = str.camelize;
BaseGenerator.prototype.capCamelize = str.capCamelize;
BaseGenerator.prototype.dasherize = str.dasherize;
BaseGenerator.prototype.humanize = str.humanize;
BaseGenerator.prototype.underscore = str.underscore;
BaseGenerator.prototype.pluralize = str.pluralize;

/*
 * Class methods
 */

BaseGenerator.extend = extend;

BaseGenerator.getGenerator = function(cmd, args, opts, hasCompanions) {
  var generatorName = BaseGenerator.getGeneratorName(cmd, args),
      generatorDir = __dirname + '/' + generatorName,
      Generator = require(generatorDir + '/' + generatorName + '_generator');

  return new Generator(generatorDir, generatorName, args, opts, hasCompanions);
};

BaseGenerator.getGeneratorName = function(cmd, args) {
  var generatorName = ('new' == cmd) ? 'app' : args[0];
  if (!!~VALID_GENERATORS.indexOf(generatorName)) {
    return generatorName;
  }
  else BaseGenerator.prototype.throwError('generator.' + generatorName, 'is not a valid rendr generator');
};

/*
 * Export it
 */

module.exports = BaseGenerator;
