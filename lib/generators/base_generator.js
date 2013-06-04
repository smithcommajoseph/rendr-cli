var fs = require('fs'),
    walk = require('walk'),
    BaseGenerator,
    extend = require('backbone').Model.extend,

    VALID_GENERATORS = ['app', 'model', 'view', 'controller', 'scaffold'];

function noop() {}

BaseGenerator = function BaseGenerator(generatorDir, generatorName, cli) {
  this.generatorDir = generatorDir;
  this.generatorName = generatorName;
  this.lang = BaseGenerator.getLang(cli);
  this.opts = this.getGeneratorOpts(cli);
  this.args = this.getGeneratorArgs(cli.args);
  this.templates = this.generatorDir + '/templates/' + this.lang;
  this.targetParent = process.cwd();
};

BaseGenerator.prototype.getGeneratorOpts = function(cli) {
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
      opts[optName] = cli[k] || cli.args[ Number(argRegex.exec(k)[1]) ];
      opts[optName] = opts[optName].toLowerCase();
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
