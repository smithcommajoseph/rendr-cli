var walk = require('walk'),
    BaseTranslator = require('../../base_translator'),
    AppTranslator,

    CONVERT_DIRS = ['javascript/app', 'javascript/server'],
    CONVERT_FILES = ['javascript/index.js'];

AppTranslator = module.exports = BaseTranslator.extend({

  translate: function translate () {
    var _this = this,
        walker = walk.walkSync(this.templatesDir, {}),
        filePath;
    
    walker.on('file', function (root, fileStats) {
      filePath = root+'/'+fileStats.name;

      if (!~fileStats.name.indexOf('.js')){
        // console.log('direct copy')
        // console.log(fileStats.name)
        _this.directCopy(filePath);
      }
      else {
        // are we in the right dir
        CONVERT_DIRS.forEach( function (convert) {
          if (!!~root.indexOf(convert)) {
            console.log('convert');
            console.log();
            _this.translateCopy(filePath);   
          }
        });
        // are we the index file
        CONVERT_FILES.forEach( function (file) {
          if (!!~(filePath).indexOf(file)) {
            console.log('file');
            // console.log(root);      
            _this.translateCopy(filePath);   
          }
        });
      }
    });
    // walker.on('end', next);
  }

});
