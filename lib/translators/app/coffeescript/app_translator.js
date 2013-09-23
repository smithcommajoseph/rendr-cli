var templates = path.resolve(__dirname, '../../../generators/app/templates/javascript');

module.exports.translate =  translate: function translateApp (err, next) {
  var _this = this;
      templates = path.resolve(__dirname, '../generators/app/templates/javascript'),
      walker = walk.walkSync(templates, {}),
      convertDirs = ['javascript/app', 'javascript/server'],
      convertFiles = ['javascript/index.js'];
      // console.log(templates);
  walker.on('file', function (root, fileStats, next) {
    // console.log(fileStats)
    if (!~fileStats.name.indexOf('.js')){
      // console.log('direct copy')
      // console.log(fileStats.name)
      _this.directCopy();
    }
    else {
      // are we in the right dir
      convertDirs.forEach( function (convert) {
        if (!!~root.indexOf(convert)) {
          console.log('convert');
          console.log();
          _this.translateCopy(root+'/'+fileStats.name, (root+'/'+fileStats.name.replace('js', 'coffee')).replace('javascript', _this.lang));   
        }
      });
      // are we the index file
      convertFiles.forEach( function (file) {
        if (!!~(root+'/'+fileStats.name).indexOf(file)) {
          console.log('file');
          // console.log(root);      
          _this.translateCopy(root+'/'+fileStats.name, (root+'/'+fileStats.name.replace('js', 'coffee')).replace('javascript', _this.lang));   
        }
      });
    }
  });

  // walker.on('end', next);
};