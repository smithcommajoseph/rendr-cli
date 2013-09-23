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
    this.type = name;
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
    
  },

  getTemplatesDir: function getTemplatesDir() {
    return  path.resolve(__dirname, '../../../generators/' + this.name + '/templates/javascript');
  },

  getTemplates: function getTemplates() {
    return  path.resolve(__dirname, '../../../generators/' + this.name + '/templates/javascript/' + this.name + '.js');
  },

  // translateApp: function translateApp (next) {
  //   var _this = this;
  //       templates = path.resolve(__dirname, '../generators/app/templates/javascript'),
  //       walker = walk.walkSync(templates, {}),
  //       convertDirs = ['javascript/app', 'javascript/server'],
  //       convertFiles = ['javascript/index.js'];
  //       // console.log(templates);
  //   walker.on('file', function (root, fileStats, next) {
  //     // console.log(fileStats)
  //     if (!~fileStats.name.indexOf('.js')){
  //       // console.log('direct copy')
  //       // console.log(fileStats.name)
  //       _this.directCopy();
  //     }
  //     else {
  //       // are we in the right dir
  //       convertDirs.forEach( function (convert) {
  //         if (!!~root.indexOf(convert)) {
  //           console.log('convert');
  //           console.log();
  //           _this.translateCopy(root+'/'+fileStats.name, (root+'/'+fileStats.name.replace('js', 'coffee')).replace('javascript', _this.lang));   
  //         }
  //       });
  //       // are we the index file
  //       convertFiles.forEach( function (file) {
  //         if (!!~(root+'/'+fileStats.name).indexOf(file)) {
  //           console.log('file');
  //           // console.log(root);      
  //           _this.translateCopy(root+'/'+fileStats.name, (root+'/'+fileStats.name.replace('js', 'coffee')).replace('javascript', _this.lang));   
  //         }
  //       });
  //     }
  //   });

  //   // walker.on('end', next);
  // },

  directCopy: function directCopy (from, to) {
    console.log('hi')
  },

  translateCopy: function translateCopy (from, to) {
    console.log("node_modules/js2coffee/out/bin/js2coffee "+from+" > "+to)
    exec("node_modules/js2coffee/out/bin/js2coffee "+from+" > "+to, function (err, stdout, stderr) {
      if (err) {
        console.log(err)
      }
      else {
        console.log('else')
      }
    });
  }

});
