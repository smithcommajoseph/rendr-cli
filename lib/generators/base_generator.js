var fs = require('fs'),
    walk = require('walk'),
    BaseGenerator,
    extend = require('backbone').Model.extend,
    validGenerators = ['app', 'model', 'view', 'controller', 'scaffold'];

function noop() {}

BaseGenerator = function BaseGenerator(generatorName, opts) {
  this.generatorName = generatorName;
  this.lang = BaseGenerator.getLang(opts);
  this.args = this.getGeneratorArgs(opts);
};

BaseGenerator.prototype.generate = function() {

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
      if (isRequired && !args[argName]) throw new Error('Missing required Argument ' + argName);
    });

    return args;
};

BaseGenerator.prototype.getTemplates = noop;

BaseGenerator.prototype.renderTemplates = noop;

BaseGenerator.prototype.parse = noop;


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

  return validGenerators.indexOf(generatorName) !== -1 ? generatorName : undefined;
};

// Ultimately, we could add other compiled languages, typescript, etc...
BaseGenerator.getLang = function(opts) {
  return (opts.coffee) ? 'coffeescript' : 'javascript';
};


/*
 * Export it
 */

module.exports = BaseGenerator;
