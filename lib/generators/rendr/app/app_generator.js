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

  initialize: function() {
    BaseGenerator.prototype.initialize.call(this);
    this.targetParent= this.targetParent + '/' + this.opts.appName;
  },

  preGenerate: function() {
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

  renderCompanions: function() {
    // render controller
    // render view
    // render templates
  }

});