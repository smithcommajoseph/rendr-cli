var AppGenerator;
	BaseGenerator = require('../../base_generator');

AppGenerator = module.exports = BaseGenerator.extend({
	
	validArgs: [
		{'new': { 'alias': 'appName' }}
	]

});