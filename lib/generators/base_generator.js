var BaseGenerator,
    fs = require('fs'),
    extend = require('backbone').Model.extend,
    validGenerators = ['app', 'model', 'view', 'controller', 'scaffold'];

function noop() {}

BaseGenerator = function BaseGenerator(generatorName, opts) {
  this.generatorName = generatorName;
  this.lang = BaseGenerator.getLang(opts);
  this.args = this.getGeneratorArgs(opts);
};

BaseGenerator.prototype.generate = function() {

};

BaseGenerator.prototype.getGeneratorArgs = function(opts) {
    var k,
        argName,
        keys = Object.keys,
        argRegex = /args\[(\d*)\]/,
        args = {};

    this.validArgs.forEach(function(validArg){
      k = keys(validArg)[0];
      argName = validArg[k].alias || k;
      args[argName] = opts[k] || opts.args[ Number(argRegex.exec(k)[1]) ];
    });

    return args;
};

BaseGenerator.prototype.getTemplates = noop;

BaseGenerator.prototype.renderTemplates = noop;

BaseGenerator.prototype.parse = noop;

// http://stackoverflow.com/q/5827612/
BaseGenerator.prototype.walk = function(dir, done) {
  var results = [];
  fs.readdir(dir, function(err, list) {
    if (err) return done(err);
    var i = 0;
    (function next() {
      var file = list[i++];
      if (!file) return done(null, results);
      file = dir + '/' + file;
      fs.stat(file, function(err, stat) {
        if (stat && stat.isDirectory()) {
          walk(file, function(err, res) {
            results = results.concat(res);
            next();
          });
        } else {
          results.push(file);
          next();
        }
      });
    })();
  });
};

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

  return validGenerators.indexOf(generatorName) !== -1 ? generatorName : undefined;
};

// Ultimately, we could add other compiled languages, typescript, etc...
BaseGenerator.getLang = function(opts) {
  return (opts.coffee) ? 'coffeescript' : 'javascript';
};


/*
 * Export it
 */

module.exports = BaseGenerator;
