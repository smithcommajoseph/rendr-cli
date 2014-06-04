var AppGenerator,
    BaseGenerator = require('../base_generator'),
    walk = require('walk'),
    fs = require('fs');

AppGenerator = module.exports = BaseGenerator.extend({

  validOpts: [
    { 'args[0]': { alias: 'appName', required: true }}
  ],

  initialize: function() {
    BaseGenerator.prototype.initialize.apply(this, arguments);
    this.targetParent= this.targetParent + '/' + this.opts.appName;
  },

  preGenerate: function(next) {
    if (this.dirExists(this.targetParent)) {
      this.logToConsole('warn', 'Application ' + this.opts.appName + ' appears to already exist');
      return false;
    }
    this.createDirectory(this.targetParent);
    next();
  },

  renderTemplates: function(next) {
    var generator = this,
        walker,
        targetDir,
        target,
        tpl,
        data,
        IGNORES = ['.gitkeep'],
        DOTTED = ['gitignore', 'nodemonignore'];

    walker = walk.walkSync(this.templates, {
      listeners: {
        file: function (root, fileStats, next) {
          targetDir = generator.targetParent + root.replace(generator.templates, '');
          target = !!~DOTTED.indexOf(fileStats.name) ? '.' + fileStats.name : fileStats.name;
          if (!generator.dirExists(targetDir)) {
            generator.createDirectory(targetDir);
          }
          if (!~IGNORES.indexOf(target)) {
            tpl = generator.compileTemplate( fs.readFileSync(root + '/' + fileStats.name, 'utf8') );
            data = tpl( generator.getTemplateData(generator) );
            generator.createFile(targetDir + '/' + target, data);
          }
        },
        end: next
      }
    });
  },

  getTemplateData: function(generator) {
    return {
      appName: {
        dasherized: generator.dasherize(generator.opts.appName),
        humanized: generator.humanize(generator.opts.appName)
      },
      filename: {
        suffix: generator.suffix
      }
    };
  },

  postGenerate: function() {
    var _this = this;
    try {
      this.logToConsole('success', 'performing \'npm install\'');
      process.chdir(this.opts.appName);
    }
    catch(err) {
      this.logToConsole('error', 'unable to \'cd\' into '+this.opts.appName);
    }
    this.runCmd('npm', ['install'], function error(err) {
      this.logToConsole('error', err);
      process.exit();
    },function end() {
      BaseGenerator.prototype.postGenerate.apply(_this, arguments);
      process.exit();
    });
  },

  getCompanions: function() {
    return [
      {
        args: ['controller','home','index'],
        appName: this.opts.appName
      },
      {
        args: ['view', 'home', 'index'],
        appName: this.opts.appName
      },
      {
        args: ['template', 'home', 'index'],
        appName: this.opts.appName
      }
    ];
  },

  displayGenerateCopy: function() {
    this.logToConsole('success', 'generated ', 'app ', this.opts.appName);

    //and some simple instructions here...
    console.log('');
    console.log('');
    console.log('  Getting Started: ');
    console.log('');
    console.log('      cd '+ this.opts.appName);
    // console.log('      npm install');
    console.log('      grunt server');
    console.log('');
    console.log('');
    console.log('  If you encounter any issues (or have feature requests!!) regarding the render-cli');
    console.log('  please report them @ https://github.com/technicolorenvy/rendr-cli/issues');
    console.log('');
    console.log('');
  }

});