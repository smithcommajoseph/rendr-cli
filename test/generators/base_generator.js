var BaseGenerator = require('../../lib/generators/base_generator'),
    AppGenerator = require('../../lib/generators/app/app_generator'),
    ModelGenerator = require('../../lib/generators/model/model_generator'),
    ViewGenerator = require('../../lib/generators/view/view_generator'),
    ControllerGenerator = require('../../lib/generators/controller/controller_generator'),
    TemplateGenerator = require('../../lib/generators/template/template_generator'),
    should = require('should'),

    APP_OPTS = {
      cmd: 'new',
      args: ['AppName']
    },

    MODEL_OPTS = {
      cmd: 'generate',
      args: ["model", "ModelName"]
    },

    VIEW_OPTS = {
      cmd: 'generate',
      args: ['view', "ViewName"]
    },

    CONTROLLER_OPTS = {
      cmd: 'generate',
      args: ['controller', "ControllerName"]
    },

    TEMPLATE_OPTS = {
      cmd: 'generate',
      args: ['template', "TemplateName"]
    };


describe("generators/base_generator", function() {

  describe("BaseGenerator.getGeneratorName", function() {
    it("should return the correct generator name", function() {
      BaseGenerator.getGeneratorName(APP_OPTS.cmd, APP_OPTS.args).should.eql('app');
      BaseGenerator.getGeneratorName(MODEL_OPTS.cmd, MODEL_OPTS.args).should.eql('model');
      BaseGenerator.getGeneratorName(VIEW_OPTS.cmd, VIEW_OPTS.args).should.eql('view');
      BaseGenerator.getGeneratorName(CONTROLLER_OPTS.cmd, CONTROLLER_OPTS.args).should.eql('controller');
      BaseGenerator.getGeneratorName(TEMPLATE_OPTS.cmd, TEMPLATE_OPTS.args).should.eql('template');
      // should.not.exist(BaseGenerator.getGeneratorName('foo', 'bar'));
    });
  });

  describe("BaseGenerator.getGenerator", function() {
    it("should return the correct generator", function() {
      (BaseGenerator.getGenerator(APP_OPTS.cmd, APP_OPTS.args, APP_OPTS) instanceof AppGenerator).should.be.ok;
      (BaseGenerator.getGenerator(MODEL_OPTS.cmd, MODEL_OPTS.args, MODEL_OPTS) instanceof ModelGenerator).should.be.ok;
      (BaseGenerator.getGenerator(VIEW_OPTS.cmd, VIEW_OPTS.args, VIEW_OPTS) instanceof ViewGenerator).should.be.ok;
      (BaseGenerator.getGenerator(CONTROLLER_OPTS.cmd, CONTROLLER_OPTS.args, CONTROLLER_OPTS) instanceof ControllerGenerator).should.be.ok;
      (BaseGenerator.getGenerator(TEMPLATE_OPTS.cmd, TEMPLATE_OPTS.args, TEMPLATE_OPTS) instanceof TemplateGenerator).should.be.ok;
    });
  });

  describe("BaseGenerator.extend", function() {
    it("should properly extend an object", function() {
      var ExtendedGenerator = BaseGenerator.extend({
            aNewProp: 'foo',
            aNewMethod: function() { return 'bar'; } 
          }),
          CLASS_METHODS = ['extend', 'getGenerator', 'getGeneratorName'],
          INSTANCE_METHODS = [
                              'initialize',
                              'getGeneratorOpts',
                              'getGeneratorArgs',
                              'dirExists',
                              'isFile',
                              'createDirectory',
                              'compileTemplate',
                              'generate',
                              'getLang',
                              'getTplEngine',
                              'getFileSuffix',
                              'getTemplateSuffix',
                              'getResourceActions',
                              'preGenerate',
                              'renderTemplates',
                              'postGenerate',
                              'getTemplateData',
                              'renderCompanions',
                              'displayGenerateCopy'
                             ];

      //confirm class methods
      CLASS_METHODS.forEach(function(method) {
        should.exist(ExtendedGenerator[method]);
      });

      //confirm instance methods
      INSTANCE_METHODS.forEach(function(method) {
        should.exist(ExtendedGenerator.__super__[method]);
      });
      should.exist(ExtendedGenerator.prototype.aNewProp);
      should.exist(ExtendedGenerator.prototype.aNewMethod);
    });
  });


  describe("getGeneratorOpts", function() {
    it("should return the correct opts", function() {
      var _thisOb = {},
          _args,
          _opts,
          actualOpts,
          namedAliasRequired    = { 'new':      { alias: 'thing', required: true }},
          namedNoAliasRequired  = { 'noAlias':  { required: true }},
          namedAliasNoRequired  = { 'jeans':    { alias: 'pants' }},
          argAliasRequired      = { 'args[0]':  { alias: 'aliasedArg', required: true }},
          argNoAliasNoRequired  = { 'args[1]':  { alias: 'aliasedArg2' }},

          fixtures = [
            {
              validOpts: [namedAliasRequired],
              passedOpts: {"new": 'testName'},
              expectedOpts: {thing: 'testName'}
            },
            {
              validOpts: [namedNoAliasRequired],
              passedOpts: {noAlias: 'testName'},
              expectedOpts: {noAlias: 'testName'}
            },
            {
              validOpts: [namedNoAliasRequired],
              passedOpts: {noAlias: true},
              expectedOpts: {noAlias: true}
            },
            {
              validOpts: [namedAliasNoRequired],
              passedOpts: {jeans: '501fly'},
              expectedOpts: {pants: '501fly'}
            },
            {
              validOpts: [namedAliasNoRequired],
              passedOpts: {shorts: '501fly'},
              expectedOpts: {pants: undefined}
            },
            {
              validOpts: [argAliasRequired],
              passedArgs: ['wassup'],
              expectedOpts: {aliasedArg: 'wassup'}
            },
            {
              validOpts: [argNoAliasNoRequired],
              passedArgs: ['one'],
              expectedOpts: {aliasedArg2: undefined}
            },
            {
              validOpts: [argNoAliasNoRequired],
              passedArgs: ['one', 'two'],
              expectedOpts: {aliasedArg2: 'two'}
            },
            {
              validOpts: [namedAliasRequired, namedNoAliasRequired, argAliasRequired],
              passedOpts: {"new": 'foo', noAlias: 'bar'},
              passedArgs: ['baz'],
              expectedOpts: {thing: 'foo', noAlias: 'bar', aliasedArg: 'baz'}
            }
          ];

      fixtures.forEach(function(fixture) {
        _thisOb.validOpts = fixture.validOpts;
        _args = fixture.passedArgs || [];
        _opts = fixture.passedOpts || {};
        actualOpts = BaseGenerator.prototype.getGeneratorOpts.call(_thisOb, _args, _opts);
        actualOpts.should.eql(fixture.expectedOpts);
      });

    });
  });

  describe("getGeneratorArgs", function() {
    it("should return the correct args", function() {
      var _thisOb = {};

      _thisOb.generatorName = 'app';
      BaseGenerator.prototype.getGeneratorArgs.call(_thisOb, []).should.eql([]);
      BaseGenerator.prototype.getGeneratorArgs.call(_thisOb, ['foo', 'bar']).should.eql(['bar']);

      _thisOb.generatorName = 'notApp';
      BaseGenerator.prototype.getGeneratorArgs.call(_thisOb, []).should.eql([]);
      BaseGenerator.prototype.getGeneratorArgs.call(_thisOb, ['foo', 'bar']).should.eql([]);
      BaseGenerator.prototype.getGeneratorArgs.call(_thisOb, ['foo', 'bar', 'baz']).should.eql(['baz']);
    });
  });

  describe("dirExists", function() {
    it("should return the correct boolean value", function() {
      BaseGenerator.prototype.dirExists(__dirname).should.be.ok;
      BaseGenerator.prototype.dirExists(__dirname + '/falsey_dirname').should.not.be.ok;
    });
  });

  describe("isFile", function() {
    it("should return the correct boolean value", function() {
      BaseGenerator.prototype.dirExists(__filename).should.be.ok;
      BaseGenerator.prototype.dirExists(__dirname + '/falsey_filename').should.not.be.ok;
    });
  });

  // describe("createDirectory", function() {

  // });

  describe("compileTemplate", function() {
    it("should return a compiled template", function() {
      BaseGenerator.prototype.compileTemplate('<h1></h1>').should.be.instanceof(Object);
    });
  });

  describe("generate", function() {
    it("should execute functions in the correct order", function(done) {
      var _thisOb = {},
          noopNext = function(next){ next(); };

      _thisOb.preGenerate = noopNext;
      _thisOb.renderTemplates = noopNext;
      _thisOb.postGenerate = function() { 
        done();
      };

      BaseGenerator.prototype.generate.call(_thisOb);
    });
  });

  describe("getLang", function() {
    it("should return the correct lang", function() {
      BaseGenerator.prototype.getLang({}).should.eql('javascript');
      BaseGenerator.prototype.getLang({coffee: true}).should.eql('coffeescript');
    });
  });

  describe("getTplEngine", function() {
    it("should return the correct tpl engine", function() {
      BaseGenerator.prototype.getTplEngine().should.eql('handlebars');
    });
  });

  describe("getFileSuffix", function() {
    it("should return the correct file suffix", function() {
      var _thisOb = {};

      _thisOb.lang = 'javascript';
      BaseGenerator.prototype.getFileSuffix.call(_thisOb).should.eql('js');
      _thisOb.lang = 'coffeescript';
      BaseGenerator.prototype.getFileSuffix.call(_thisOb).should.eql('coffee');
    });

  });

  describe("getTemplateSuffix", function() {
    it("should return the correct template suffix", function() {
      var _thisOb = {};

      _thisOb.tplEngine = 'handlebars';
      BaseGenerator.prototype.getTemplateSuffix.call(_thisOb).should.eql('hbs');
    });
  });

  describe("getResourceActions", function() {
    it("should return the correct resource actions", function() {
      var _thisOb = {};

      _thisOb.args = [];
      BaseGenerator.prototype.getResourceActions.call(_thisOb).should.eql(['index']);
      _thisOb.args = ['show', 'me', 'tha', 'money'];
      BaseGenerator.prototype.getResourceActions.call(_thisOb).should.eql(_thisOb.args);
    });
  });

  describe("capitalize", function() {
    it("should return a capitalized string", function() {
      BaseGenerator.prototype.capitalize('howdy').should.eql('Howdy');
      BaseGenerator.prototype.capitalize('heyThereFolks').should.eql('Heytherefolks');
    });
  });

  describe("camelize", function() {
    it("should return a camelized string", function() {
      BaseGenerator.prototype.camelize('Hey there folks').should.eql('heyThereFolks');
    });
  });

  describe("capCamelize", function() {
    it("should return a capCamelized string", function() {
      BaseGenerator.prototype.capCamelize('Hey there folks').should.eql('HeyThereFolks');
    });
  });

  describe("dasherize", function() {
    it("should return a dasherized string", function() {
      BaseGenerator.prototype.dasherize('HeyThereFolks').should.eql('hey-there-folks');
    });
  });

  describe("humanize", function() {
    it("should return a humanized string", function() {
      BaseGenerator.prototype.humanize('HeyThereFolks').should.eql('Hey there folks');
    });
  });

  describe("underscore", function() {
    it("should return an underscored string", function() {
      BaseGenerator.prototype.underscore('HeyThereFolks').should.eql('hey_there_folks');
    });
  });

  describe("pluralize", function() {
    it("should return an pluralized string", function() {
      BaseGenerator.prototype.pluralize('cat').should.eql('cats');
      BaseGenerator.prototype.pluralize('person').should.eql('people');
    });
  });

});