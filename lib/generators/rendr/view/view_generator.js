var ViewGenerator,
    BaseGenerator = require('../../base_generator'),
    fs = require('fs'),
    walk = require('walk'),
    Handlebars = require('handlebars');

ViewGenerator = module.exports = BaseGenerator.extend({
  
  validArgs: [
    {'args[0]': { alias: 'viewName', required: true }}
  ],

  preGenerate: function() {
    this.targetParent = this.targetParent + '/app/views/' + this.args.viewName;
    if (this.dirExists(this.targetParent)) {
      console.log('View ' + this.args.viewName + ' appears to already exist');
      return false;
    }
    this.createDirectory(this.targetParent, true);
  },

  renderTemplates: function() {
    var generator = this,
        walker = walk.walkSync(this.templates, {}),
        tpl,
        data,
        sfx,
        action = 'index';

    walker.on('file', function (root, fileStats, next) {
      tpl = Handlebars.compile(fs.readFileSync(root + '/' + fileStats.name, 'utf8'));
      data = tpl({name: generator.args.viewName, action: action});
      sfx = generator.getFileSuffix();
      fs.writeFileSync(generator.targetParent + '/' + action + '.' + sfx, data);
    });
  },

  // postGenerate: function() {
  //   this.generateHomeView();
  // },


});