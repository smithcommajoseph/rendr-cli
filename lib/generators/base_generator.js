var BaseGenerator,
  extend = require('backbone').Model.extend,
  validGenerators = ['app', 'model', 'view', 'controller', 'scaffold'];

function noop() {}

BaseGenerator = function BaseGenerator(generatorName, opts) {
  this.generatorName = generatorName;
  this.lang = BaseGenerator.getLang(opts);
};

BaseGenerator.extend = extend;

BaseGenerator.getGeneratorName = function(opts) {
  var generatorName;

  if (opts.new) {
    generatorName = 'app';
  }
  else if (opts.generator) {
    generatorName = opts.generator;
  }

  return validGenerators.indexOf(generatorName) !== -1 ? generatorName : undefined;
};

BaseGenerator.getLang = function(opts) {
  return (opts.coffee) ? 'coffeescript' : 'javascript';
};

module.exports = BaseGenerator;
