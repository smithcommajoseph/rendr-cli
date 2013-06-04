var AppGenerator,
  BaseGenerator = require('../../base_generator'),
  walk = require('walk'),
  fs = require('fs'),

  IGNORES = ['.gitkeep'],
  DOTTED = ['gitignore', 'nodemonignore'];

AppGenerator = module.exports = BaseGenerator.extend({
  
  validOpts: [
    { 'new': { alias: 'appName', required: true }}
  ],

  preGenerate: function() {
    this.targetParent = this.targetParent + '/' + this.opts.appName;
    if (this.dirExists(this.targetParent)) {
      console.log('Application ' + this.opts.appName + ' appears to already exist');
      return false;
    }
    this.createDirectory(this.targetParent, true);
  },

  renderTemplates: function() {
    var generator = this,
        walker = walk.walkSync(this.templates, {}),
        targetDir,
        target;

    walker.on('file', function (root, fileStats, next) {
      targetDir = generator.targetParent + root.replace(generator.templates, '');
      target = !!~DOTTED.indexOf(fileStats.name) ? '.' + fileStats.name : fileStats.name;
      if (!generator.dirExists(targetDir)) {
        generator.createDirectory(targetDir, true);
      }
      if (!~IGNORES.indexOf(target)) {
        console.log('Generating ' +  targetDir + '/' + target);
        fs
          .createReadStream( root + '/' + fileStats.name )
          .pipe(fs.createWriteStream( targetDir + '/' + target ) );
      }
    });
  },

  postGenerate: function() {
    this.generateHomeView();
  },

  generateHomeView: function() {
    // we'll use our own view generator to stub out a home view here

  }

});