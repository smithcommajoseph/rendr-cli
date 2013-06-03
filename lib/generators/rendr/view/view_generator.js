var ViewGenerator,
    BaseGenerator = require('../../base_generator'),
    fs = require('fs'),

    VIEW_DIRS = ['controllers', 'templates', 'views'];

ViewGenerator = module.exports = BaseGenerator.extend({
  
  validArgs: [
    {'args[0]': { alias: 'viewName', required: true }}
  ],

  preGenerate: function() {
    this.targetParent = this.targetParent + '/app';

    if (this.viewDirectoriesExist()) {
      console.log('View ' + this.args.viewName + ' appears to already exist');
      return false;
    }
    this.createViewDirectories();
  },

  viewDirectoriesExist: function() {
    var exist = false,
        viewDir;
    for(var i = 0, len = VIEW_DIRS.length; i<len; i++) {
      viewDir = this.targetParent + '/' + VIEW_DIRS[i] + '/' + this.args.viewName;
      if ( this.dirExists(viewDir) ) return (exist = true);
    }
    return exist;
  },

  createViewDirectories: function() {
    var viewDir;
    for(var i = 0, len = VIEW_DIRS.length; i<len; i++) {
      viewDir = this.targetParent + '/' + VIEW_DIRS[i] + '/' + this.args.viewName;
      fs.mkdirSync(viewDir);
    }
  }

  // postGenerate: function() {
  //   this.generateHomeView();
  // },


});