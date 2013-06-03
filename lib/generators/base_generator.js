var fs = require('fs'),
    walk = require('walk'),
    BaseGenerator,
    extend = require('backbone').Model.extend,

    VALID_GENERATORS = ['app', 'model', 'view', 'controller', 'scaffold'],
    IGNORES = ['.gitkeep'],
    DOTTED = ['gitignore', 'nodemonignore'];

function noop() {}

BaseGenerator = function BaseGenerator(generatorDir, generatorName, opts) {
  this.generatorDir = generatorDir;
  this.generatorName = generatorName;
  this.lang = BaseGenerator.getLang(opts);
  this.args = this.getGeneratorArgs(opts);
  this.templates = this.generatorDir + '/templates/' + this.lang;
  this.targetParent = process.cwd();
};

BaseGenerator.prototype.getGeneratorArgs = function(opts) {
    var k,
        argName,
        isRequired,
        keys = Object.keys,
        argRegex = /args\[(\d*)\]/,
        args = {};

    this.validArgs.forEach(function(validArg){
      k = keys(validArg)[0];
      argName = validArg[k].alias || k;
      isRequired = validArg[k].required || false;
      args[argName] = opts[k] || opts.args[ Number(argRegex.exec(k)[1]) ];
      if (isRequired && !args[argName]) throw new Error('Missing required Argument ' + argName);
    });

    return args;
};

BaseGenerator.prototype.preGenerate = noop;

BaseGenerator.prototype.generate = function() {
  if ( this.preGenerate() === false ) return;
  if ( this.renderTemplates() === false ) return;
  this.postGenerate();
};

BaseGenerator.prototype.postGenerate = noop;


BaseGenerator.prototype.renderTemplates = function() {
  var opts = {},
      walker = walk.walkSync(this.templates, opts),
      templates = this.templates,
      dirExists = this.dirExists,
      targetParent = this.targetParent,
      targetDir,
      target;

  walker.on("file", function (root, fileStats, next) {
    targetDir = root.replace(templates, '');
    target = !!~DOTTED.indexOf(fileStats.name) ? '.' + fileStats.name : fileStats.name;
    // console.log(targetParent + targetDir + '/' + target);

    if (!~IGNORES.indexOf(target)) {
      if ( !dirExists( targetParent + targetDir ) ) {
        console.log('Creating Directory ' + targetParent + targetDir);
        fs.mkdirSync( targetParent + targetDir );
      }
      console.log('Generating ' +  targetParent + targetDir + '/' + target);
      fs.createReadStream( root + '/' + fileStats.name ).pipe(fs.createWriteStream( targetParent + targetDir + '/' + target ) );
    }
    // console.log('data is ');
    // console.log( fs.readFileSync(root + '/' + fileStats.name, 'utf8') );
    // console.log(' ');
  });
};

BaseGenerator.prototype.dirExists = function(dir) {
  var retVal;
  try { fs.statSync(dir).isDirectory(); retVal = true;}
  catch (er) { retVal = false; }
  return retVal;
};

BaseGenerator.prototype.parse = noop;


/*
 * Class methods
 */

BaseGenerator.extend = extend;

BaseGenerator.getGeneratorName = function(opts) {
  var generatorName;

  if (opts.new) {
    generatorName = 'app';
  }
  else if (opts.generate) {
    generatorName = opts.generate;
  }

  return !!~VALID_GENERATORS.indexOf(generatorName) ? generatorName : undefined;
};

// Ultimately, we could add other compiled languages, typescript, etc...
BaseGenerator.getLang = function(opts) {
  return (opts.coffee) ? 'coffeescript' : 'javascript';
};


/*
 * Export it
 */

module.exports = BaseGenerator;
