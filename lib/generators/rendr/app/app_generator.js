var AppGenerator,
  BaseGenerator = require('../../base_generator'),
  fs = require('fs');

AppGenerator = module.exports = BaseGenerator.extend({
  
  validArgs: [
    { 'new': { alias: 'appName', required: true }}
  ],

  preGenerate: function() {
    this.targetParent = this.targetParent + '/' + this.args.appName;
    if (this.appDirectoryExists()) {
      console.log('Application ' + this.args.appName + ' appears to already exist');
      return false;
    }
    this.createAppDirectory();
  },

  appDirectoryExists: function() {
    return fs.statSync(this.targetParent).isDirectory();
  },

  createAppDirectory: function() {
    console.log('creating directory ' + this.targetParent);
    fs.mkdirSync(this.targetParent);
  },

  postGenerate: function() {
    this.generateHomeView();
  },

  generateHomeView: function() {
    // we'll use our own view generator to stub out a home view here

  }

});