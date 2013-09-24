var fs = require('fs-extra'),
    walk = require('walk'),
    path = require('path'),
    BaseCliOb = require('../base_cli_ob'),
    exec = require('child_process').exec,
    BaseTranslator;

BaseTranslator = module.exports = BaseCliOb.extend({

  initialize: function initialize (lang, suffix, name){
    this.lang = lang;
    this.suffix = suffix;
    this.name = name;
    this.templatesDir = this.getTemplatesDir();
    this.templates = this.getTemplates();
    this.translationDir = this.getTranslationDir();
    this.CONVERT_DIRS = ['javascript'];
  },

  translate: function translate () {
    var _this = this,
        walker = walk.walkSync(this.templatesDir, {}),
        filePath;

    this.createTranslatedDir();

    walker.on('file', function (root, fileStats) {
      filePath = root+'/'+fileStats.name;

      if (!~fileStats.name.indexOf('.js') || !!~fileStats.name.indexOf('.json')){
        _this.directCopy(filePath);
      }
      else {
        // are we in the right dir
        _this.CONVERT_DIRS.forEach( function (convert) {
          if (!!~root.indexOf(convert)) {
            _this.translateCopy(filePath);   
          }
        });
        // are we the index file
        _this.CONVERT_FILES.forEach( function (file) {
          if (!!~(filePath).indexOf(file)) {     
            _this.translateCopy(filePath);   
          }
        });
      }
    });
  },

  clearTranslation: function clearTranslations () {
    fs.removeSync(this.translationDir);
    return this;
  },

  createTranslatedDir: function createTranslatedDir () {
    fs.mkdirsSync(this.translationDir);
    return this;
  },

  getTemplatesDir: function getTemplatesDir() {
    return  path.resolve(__dirname, '../generators/' + this.name + '/templates/javascript');
  },

  getTemplates: function getTemplates() {
    return  path.resolve(__dirname, '../generators/' + this.name + '/templates/javascript/' + this.name + '.js');
  },

  getTranslationDir: function getTranslationDir () {
    return  path.resolve(__dirname, '../generators/' + this.name + '/templates/' + this.lang);
  },

  createDirIfNotExists: function createDirIfNotExists (filePath) {
    var parentDir = this.getParentDir(filePath);
    if (!fs.existsSync(parentDir)) fs.mkdirsSync(parentDir);
  },

  getParentDir: function getParentDir (filePath) {
    var a = filePath.split('/');
    a.pop();
    return a.join('/');
  },

  directCopy: function directCopy (filePath) {
    var to = this.updateFileDir(filePath),
        data =  fs.readFileSync(filePath);
    this.createDirIfNotExists(to);
    this.createFile(to, data);
  },

  translateCopy: function translateCopy (filePath) {
    var from = filePath,
        to = this.translateFileName(filePath);
    this.createDirIfNotExists(to);
    exec("node_modules/js2coffee/out/bin/js2coffee "+from+" > "+to, function (err, stdout, stderr) {
      if (err) console.log(err);
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
