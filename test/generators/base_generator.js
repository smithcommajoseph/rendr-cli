var BaseGenerator = require('../../lib/generators/base_generator'),
    AppGenerator = require('../../lib/generators/rendr/app/app_generator'),
    ModelGenerator = require('../../lib/generators/rendr/model/model_generator'),
    ViewGenerator = require('../../lib/generators/rendr/view/view_generator'),
    ControllerGenerator = require('../../lib/generators/rendr/controller/controller_generator'),
    TemplateGenerator = require('../../lib/generators/rendr/template/template_generator'),
    should = require('should'),

    APP_OPTS = {
      "new": 'AppName',
      args: []
    },

    MODEL_OPTS = {
      generate: 'model',
      args: ["ModelName"]
    },

    VIEW_OPTS = {
      generate: 'view',
      args: ["ViewName"]
    },

    CONTROLLER_OPTS = {
      generate: 'controller',
      args: ["ControllerName"]
    },

    TEMPLATE_OPTS = {
      generate: 'template',
      args: ["TemplateName"]
    };


describe("generators/base_generator", function() {

  describe("BaseGenerator.getGeneratorName", function() {
    it("should return the correct generator name", function() {
      BaseGenerator.getGeneratorName(APP_OPTS).should.eql('app');
      BaseGenerator.getGeneratorName(MODEL_OPTS).should.eql('model');
      BaseGenerator.getGeneratorName(VIEW_OPTS).should.eql('view');
      BaseGenerator.getGeneratorName(CONTROLLER_OPTS).should.eql('controller');
      BaseGenerator.getGeneratorName(TEMPLATE_OPTS).should.eql('template');
      should.not.exist(BaseGenerator.getGeneratorName('foo'));
    });
  });

  describe("BaseGenerator.getGenerator", function() {
    it("should return the correct generator", function() {
      (BaseGenerator.getGenerator(APP_OPTS) instanceof AppGenerator).should.be.ok;
      (BaseGenerator.getGenerator(MODEL_OPTS) instanceof ModelGenerator).should.be.ok;
      (BaseGenerator.getGenerator(VIEW_OPTS) instanceof ViewGenerator).should.be.ok;
      (BaseGenerator.getGenerator(CONTROLLER_OPTS) instanceof ControllerGenerator).should.be.ok;
      (BaseGenerator.getGenerator(TEMPLATE_OPTS) instanceof TemplateGenerator).should.be.ok;
    });
  });

  describe("BaseGenerator.extend", function() {
    it("should properly extend and object", function() {
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
                              'displayCopy'
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
              expectedOpts: {thing: 'testname'}
            },
            {
              validOpts: [namedNoAliasRequired],
              passedOpts: {noAlias: 'testName'},
              expectedOpts: {noAlias: 'testname'}
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
              passedOpts: {args: ['wassup']},
              expectedOpts: {aliasedArg: 'wassup'}
            },
            {
              validOpts: [argNoAliasNoRequired],
              passedOpts: {args: ['one']},
              expectedOpts: {aliasedArg2: undefined}
            },
            {
              validOpts: [argNoAliasNoRequired],
              passedOpts: {args: ['one', 'two']},
              expectedOpts: {aliasedArg2: 'two'}
            },
            {
              validOpts: [namedAliasRequired, namedNoAliasRequired, argAliasRequired],
              passedOpts: {"new": 'foo', noAlias: 'bar', args: ['baz']},
              expectedOpts: {thing: 'foo', noAlias: 'bar', aliasedArg: 'baz'}
            }
          ];

      fixtures.forEach(function(fixture) {
        _thisOb.validOpts = fixture.validOpts;
        actualOpts = BaseGenerator.prototype.getGeneratorOpts.call(_thisOb, fixture.passedOpts);
        actualOpts.should.eql(fixture.expectedOpts);
      });

    })
  });

  describe("getGeneratorArgs", function() {
    it("should return the correct args", function() {
      BaseGenerator.prototype.getGeneratorArgs([]).should.eql([]);
      BaseGenerator.prototype.getGeneratorArgs(['foo', 'bar']).should.eql(['bar']);
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

});