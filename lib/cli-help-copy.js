module.exports = {

  description: function() {
    console.log('  Description: ')
    console.log('      The \'rendr new\' command creates a new Rendr application with a default directory structure');
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
    console.log('      By default, generating a model will provide you a bare-bones scaffolded model file');
    console.log('      containing empty values for your url and idAttrubutes keys.');
    console.log('      ');
    console.log('      For example:');
    console.log('         rendr generate model MODELNAME');
    console.log('      ');
    console.log('      This generates a nearly empty model at APPNAME/app/models/MODELNAME');
    console.log('      ');
    console.log('      You may make the model more useful by optionally passing the \'--url\', \'--idAttrubute\',');
    console.log('      or \'--apiHost\' flags. These flagnames match exactly the resulting keys, and values, ');
    console.log('      that are produced in the generated model.');
    console.log('      ');
  },

  views: function() {
    console.log('  Views: ');
    console.log('      Views will automatically generate the associated controllers + templates directories/files');
    console.log('      ');
    console.log('      If you wish to add more actions to your view, beyond the default \'index\' action');
    console.log('      you may pass additional arguments to the generator like so');
    console.log('      ');
    console.log('      For example:');
    console.log('          $ rendr generate view VIEWNAME action1 action2 action3');
    console.log('      ');
    console.log('      Will generate the action1, action2, and action3 view files in the APPNAME/app/views/VIEWNAME');
    console.log('      directory.');
    console.log('      It will also generate the corresponding controller APPNAME/app/controllers/VIEWNAME');
    console.log('      And templates for action1, action2, and action3 in the APPNAME/app/templates/VIEWNAME directory.');
    console.log('      ');
    console.log('      Additionally, when called from the command-line');
    console.log('      ');
    console.log('          $ rendr g view');
    console.log('          and');
    console.log('          $ rendr g controller');
    console.log('      ');
    console.log('      are functionaly the same, \'controller\' is provided as a convience');
    console.log('      ');
  }
};