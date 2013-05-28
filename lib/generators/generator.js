var BaseGenerator = require('./base_generator');

module.exports = function generator (cli) {
  var generatorName = BaseGenerator.getGeneratorName(cli),
      generatorDir = __dirname + '/rendr/' + generatorName,
      Generator = require(generatorDir + '/' + generatorName + '_generator');

  return new Generator(generatorDir, generatorName, cli);
};
