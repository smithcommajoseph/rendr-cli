var ModelGenerator,
    BaseGenerator = require('../../base_generator');

ModelGenerator = module.exports = BaseGenerator.extend({
  
  validArgs: [
    {'args[0]': { alias: 'modelName', required: true }}
  ]

});