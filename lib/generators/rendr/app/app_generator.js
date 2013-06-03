var AppGenerator,
	BaseGenerator = require('../../base_generator'),
	fs = require('fs');

AppGenerator = module.exports = BaseGenerator.extend({
	
	validArgs: [
		{ 'new': { alias: 'appName', required: true }}
	],

	preGenerate: function() {
    this.targetParent = this.targetParent + '/' + this.args.appName;

		if (!this.AppDirectoryExists()) {
			console.log('Directory ' + this.args.appName + ' already exists');
			return false;
		}
		console.log('creating directory ' + this.targetParent);
		fs.mkdirSync(this.targetParent)
	},

	AppDirectoryExists: function() {
		console.log('checkIfAppDirectoryExists');
		return true;
	},

	postGenerate: function() {
		this.generateHomeView();
	},

	generateHomeView: function() {
		// we'll use our own view generator to stub out a home view here

	}

});