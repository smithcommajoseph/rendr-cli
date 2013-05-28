var AppGenerator,
	BaseGenerator = require('../../base_generator');

AppGenerator = module.exports = BaseGenerator.extend({
	
	validArgs: [
		{ 'new': { alias: 'appName', required: true }}
	],

	preGenerate: function() {
		this.checkIfAppDirectoryExists();
		return true;
	},

	checkIfAppDirectoryExists: function() {
		console.log('checkIfAppDirectoryExists');
	}


});