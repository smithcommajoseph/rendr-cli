module.exports = {

  description: function() {
    console.log('  Description: ')
    console.log('      The rendr new command creates a new Rendr application with a default directory structure');
    console.log('      and configuration relative to the directory you are executing the command from.');
    console.log('      ');
    console.log('      For example:');
    console.log('         rendr new APPNAME');
    console.log('      ');
    console.log('      This generates a skeletal Rendr installation in <current path>/APPNAME.');
    console.log('      ');
  },

  models: function() {
    console.log('  Models: ')
    console.log('      By default, generating a model will provide you a bare-bones, scaffolded model file');
    console.log('      containing empty values for your url and idAttrubutes keys.');
    console.log('      ');
    console.log('      For example:');
    console.log('         rendr generate model MODELNAME');
    console.log('      ');
    console.log('      This generates a model at APPNAME/app/models/MODELNAME');
    console.log('      ');
    console.log('      You may make the model more useful by optionally passing the --url, --idAttrubute,');
    console.log('      or --apiHost flags. These flagnames match exactly the resulting keys, and values, ');
    console.log('      that are produced in the generated model.');
    console.log('      ');
  },

  views: function() {
    console.log('  Views: ');
    console.log('      Generating a view will produce multiple bare view files. One for each action');
    console.log('      (index, if none are specified).');
    console.log('      ');
    console.log('      Additionally, views will automatically generate the associated templates directories/files');
    console.log('      unless the --noTemplates option is specified');
    console.log('      ');
    console.log('      If you wish to add more actions to your view, beyond the default index action');
    console.log('      you may pass additional arguments to the generator like so');
    console.log('      ');
    console.log('      For example:');
    console.log('          $ rendr generate view VIEWNAME ACTION1 ACTION2 ACTION3');
    console.log('      ');
    console.log('      Will generate the ACTION1, ACTION2, and ACTION3 view files in the APPNAME/app/views/VIEWNAME');
    console.log('      directory.');
    console.log('      AND templates for ACTION1, ACTION2, and ACTION3 in the APPNAME/app/templates/VIEWNAME directory.');
    console.log('      ');
  },

  controllers: function() {
    console.log('  Controllers: ');
    console.log('      Controller files will be generated with an entry for each action (index, if none are specified).');
    console.log('      ');
    console.log('      Like views, if you wish to add more actions to your controller, beyond the default index action');
    console.log('      you may pass additional arguments to the generator like so');
    console.log('      ');
    console.log('      For example:');
    console.log('          $ rendr generate controller CONTROLLERNAME ACTION1 ACTION2 ACTION3');
    console.log('      ');
    console.log('      Will generate the ACTION1, ACTION2, and ACTION3 controller entries in the APPNAME/app/controllers/CONTROLLERNAME');
    console.log('      directory.');
    console.log('      ');
  },

  scaffolds: function() {
    console.log('  Scaffolds: ');
    console.log('      Scaffolds will generate views and controllers, as such they follow all the same rules and optional flags');
    console.log('      ');
    console.log('      For example:');
    console.log('          $ rendr generate scaffold SCAFFOLDNAME ACTION1 ACTION2 ACTION3');
    console.log('      ');
    console.log('      Will generate the ACTION1, ACTION2, and ACTION3 view files in the APPNAME/app/views/SCAFFOLDNAME');
    console.log('      directory.');
    console.log('      AND templates for ACTION1, ACTION2, and ACTION3 in the APPNAME/app/templates/SCAFFOLDNAME directory.');
    console.log('      Will generate the ACTION1, ACTION2, and ACTION3 controller entries in the APPNAME/app/controllers/SCAFFOLDNAME');
    console.log('      ');
  }

};