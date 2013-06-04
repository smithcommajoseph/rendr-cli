var fs = require('fs'),
    walk = require('walk'),
    BaseGenerator,
    extend = require('backbone').Model.extend,

    VALID_GENERATORS = ['app', 'model', 'view', 'controller', 'scaffold'];

function noop() {}

BaseGenerator = function BaseGenerator(generatorDir, generatorName, opts) {
  this.generatorDir = generatorDir;
  this.generatorName = generatorName;
  this.lang = BaseGenerator.getLang(opts);
  this.args = this.getGeneratorArgs(opts);
  this.templates = this.generatorDir + '/templates/' + this.lang;
  this.targetParent = process.cwd();
};

BaseGenerator.prototype.getGeneratorArgs = function(opts) {
    var k,
        argName,
        isRequired,
        keys = Object.keys,
        argRegex = /args\[(\d*)\]/,
        args = {};

    this.validArgs.forEach(function(validArg){
      k = keys(validArg)[0];
      argName = validArg[k].alias || k;
      isRequired = validArg[k].required || false;
      args[argName] = opts[k] || opts.args[ Number(argRegex.exec(k)[1]) ];
      args[argName] = args[argName].toLowerCase();
      if (isRequired && !args[argName]) throw new Error('Missing required Argument ' + argName);
    });

    return args;
};

BaseGenerator.prototype.dirExists = function(dir) {
  var retVal = false;
  try { fs.statSync(dir).isDirectory(); retVal = true;}
  catch (er) { }
  return retVal;
};

BaseGenerator.prototype.createDirectory = function(dir, verbose) {
  if (!!verbose) console.log('creating directory ' + dir);
  fs.mkdirSync(dir);  
};

BaseGenerator.prototype.generate = function() {
  if ( this.preGenerate() === false ) return;
  if ( this.renderTemplates() === false ) return;
  this.postGenerate();
};

BaseGenerator.prototype.getFileSuffix = function() {
  var langSuffixMap = {
    'javascript': 'js',
    'coffeescript': 'coffee'
  };

  return langSuffixMap[this.lang];
}

BaseGenerator.prototype.preGenerate = noop;

BaseGenerator.prototype.renderTemplates = noop;

BaseGenerator.prototype.postGenerate = noop;

/*
 * Class methods
 */

BaseGenerator.extend = extend;

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
