var BaseGenerator = require('./base_generator');

module.exports = function generator (cli) {
  var generatorName = BaseGenerator.getGeneratorName(cli),
      Generator = require('./rendr/' + generatorName + '/' + generatorName + '_generator');

  return new Generator(generatorName, cli);
};
