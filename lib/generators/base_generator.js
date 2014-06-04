var _ = require('underscore'),
    async = require('async'),
    spawn = require('child_process').spawn,
    readline = require('readline'),
    BaseCliOb = require('../base_cli_ob'),
    BaseGenerator,

    VALID_GENERATORS = ['app', 'model', 'collection', 'view', 'controller', 'template', 'scaffold'];

function noop() {}
function passThrough(next) { next(); }

BaseGenerator = module.exports = BaseCliOb.extend({

  initialize: function initialize (generatorDir, generatorName, args, opts, hasCompanions) {
    this.generatorDir   = generatorDir;
    this.generatorName  = generatorName;
    this.program        = opts; //hold on to a ref of the cli program itself
    this.lang           = this.getLang(opts);
    this.suffix         = this.getFileSuffix();
    this.tplEngine      = this.getTplEngine(opts);
    this.opts           = this.getGeneratorOpts(args, opts);
    this.args           = this.getGeneratorArgs(args);
    this.templates      = this.generatorDir + '/templates/' + this.lang;
    this.targetParent   = process.cwd();
    this.hasCompanions  = typeof hasCompanions === "undefined" ? true : hasCompanions;
    this.verbose        = true;
  },

  getGeneratorOpts: function getGeneratorOpts (args, options) {
      var k,
          optName,
          isRequired,
          keys = Object.keys,
          argRegex = /args\[(\d*)\]/,
          opts = {},
          generator = this;

      this.validOpts.forEach(function(validOpt){
        k = keys(validOpt)[0];
        optName = validOpt[k].alias || k;
        isRequired = validOpt[k].required || false;
        try{
          opts[optName] = options[k] || args[ Number(argRegex.exec(k)[1]) ];
        }
        catch(err) { opts[optName] = undefined; }
        if (isRequired && !opts[optName]) generator.throwError('generator.' + this.generatorName, 'Missing ' + optName);
      });

      return opts;
  },

  getGeneratorArgs: function getGeneratorArgs (args) {
    return this.generatorName == "app" ? args.slice(1) : args.slice(2);
  },

  compileTemplate: function compileTemplate (template) {
    return _.template(template);
  },

  generate: function generate () {
    async.series([
      this.preGenerate.bind(this),
      this.renderTemplates.bind(this),
      this.postGenerate.bind(this)
    ]);
  },

  new: function () {
    this.generate();
  },

  destroy: function destroy () {
    async.series([
      this.preDestroy.bind(this),
      this.deleteTemplates.bind(this),
      this.postDestroy.bind(this)
    ]);
  },

  // Ultimately, we could add other compiled languages, typescript, etc...
  getLang: function getLang (opts) {
    return (opts.coffee) ? 'coffeescript' : 'javascript';
  },

  // Ultimately, we could add other templating engines as well once they are supported by Rendr
  getTplEngine: function getTplEngine (opts) {
    return 'handlebars';
  },

  getFileSuffix: function getFileSuffix () {
    var langSuffixMap = {
      'javascript': 'js',
      'coffeescript': 'coffee'
    };
    return langSuffixMap[this.lang];
  },

  getTemplateSuffix: function getTemplateSuffix () {
    var tplSuffixMap = {
      'handlebars': 'hbs'
    };
    return tplSuffixMap[this.tplEngine];
  },

  getResourceActions: function getResourceActions () {
    var DEFAULT_ACTIONS = ['index'];
    return this.args.length > 0 ? this.args : DEFAULT_ACTIONS;
  },

  getCompanions: noop,

  // generate fns
  preGenerate: passThrough,

  renderTemplates: passThrough,

  postGenerate: function postGenerate () {
    if (this.hasCompanions) {
      var companions = this.getCompanions();
      this.renderCompanions(companions);
    }
    this.displayGenerateCopy();
  },

  getTemplateData: noop,

  renderCompanions: function renderCompanions (companions) {
    var _this = this, generator;
    companions.forEach(function(companion){
      companion.coffee = _this.program.coffee;
      generator = BaseGenerator.getGenerator('generate', companion.args, companion, false);
      generator.generate();
    });
  },

  displayGenerateCopy:  noop,

  // destroy fns
  preDestroy: function preDestroy (next) {
    var generator = this;
    this.program.confirm('This will destroy ' + this.generatorName.underline + ' ' + this.opts[this.generatorName+'Name'].bold + '. You good with that? (y/n) ', function(ok){
      if (!ok) {
        generator.logToConsole('warn', 'destroy canceled');
        process.exit();
      }
      else next();
    });
  },

  deleteTemplates: passThrough,

  postDestroy: function postDestroy () {
    if (this.hasCompanions) {
      var companions = this.getCompanions();
      this.destroyCompanions(companions);
    }
    this.displayDestroyCopy();
    process.exit(); // explicit exit
  },

  destroyCompanions: function destroyCompanions (companions) {
    var generator;
    companions.forEach(function(companion){
      generator = BaseGenerator.getGenerator('destroy', companion.args, companion, false);
      generator.destroy();
    });
  },

  displayDestroyCopy: noop,

  runCmd: function runCmd(cmd, args, error, end) {
    var child = spawn(cmd, args, {stdio: 'inherit'});
    // child.stdout.pipe(process.stdout);
    child.stderr.pipe(process.stderr);
    child.stdout.on('end', end);
    child.stdout.on('error', error);
    process.on('exit', function() {
      console.log('exit fired')
    });
    process.once("SIGTERM", function () {
      console.log('SIGTERM fired')
      child.kill(); // don't shake the baby
      process.exit(0);
    });
  }

},

/*
 * Class methods
 */

{

  getGenerator: function getGenerator (cmd, args, opts, hasCompanions) {
    var generatorName = BaseGenerator.getGeneratorName(cmd, args),
        generatorDir = __dirname + '/' + generatorName,
        Generator = require(generatorDir + '/' + generatorName + '_generator');

    return new Generator(generatorDir, generatorName, args, opts, hasCompanions);
  },

  getGeneratorName: function getGeneratorName (cmd, args) {
    var generatorName = ('new' == cmd) ? 'app' : args[0];
    if (!!~VALID_GENERATORS.indexOf(generatorName)) {
      return generatorName;
    }
    else BaseCliOb.prototype.throwError('generator.' + generatorName, 'is not a valid rendr generator');
  }

});
