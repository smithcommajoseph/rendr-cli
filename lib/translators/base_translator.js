var fsx = require('fs-extra'),
    path = require('path'),
    BaseCliOb = require('../base_cli_ob'),
    exec = require('child_process').exec,
    BaseTranslator;


function noop() {}

BaseTranslator = module.exports = BaseCliOb.extend({

  initialize: function initialize (lang, suffix, name){
    this.lang = lang;
    this.suffix = suffix;
    this.name = name;
    this.templatesDir = this.getTemplatesDir();
    this.templates = this.getTemplates();
  },

  translate: function translate () {
    // VALID_TRANSLATORS.forEach( function( name ) {
    //   var translator = require('.' + name + '/' + this.lang);
    //   translator.translate();
    // });
  },

  clearTranslation: function clearTranslations () {
    //
    return this;
  },

  getTemplatesDir: function getTemplatesDir() {
    return  path.resolve(__dirname, '../generators/' + this.name + '/templates/javascript');
  },

  getTemplates: function getTemplates() {
    return  path.resolve(__dirname, '../generators/' + this.name + '/templates/javascript/' + this.name + '.js');
  },

  directCopy: function directCopy (filePath) {
    var from = filePath,
        to = this.updateFileDir(filePath);
    //write file to the above path
  },

  translateCopy: function translateCopy (filePath) {
    var from = filePath,
        to = this.translateFileName(filePath);
    console.log("node_modules/js2coffee/out/bin/js2coffee "+from+" > "+to)
    exec("node_modules/js2coffee/out/bin/js2coffee "+from+" > "+to, function (err, stdout, stderr) {
      if (err) {
        console.log(err)
      }
      else {
        console.log('else')
      }
    });
  },

  updateFileDir: function updateFileDir (filePath) {
    return filePath.replace('javascript', this.lang);
  },

  translateFileSuffix: function updateFileSuffix (filePath) {
    return filePath.replace('js', this.suffix);
  },

  translateFileName: function translateFileName (filePath) {
    return this.updateFileDir(this.translateFileSuffix(filePath));
  }

});
