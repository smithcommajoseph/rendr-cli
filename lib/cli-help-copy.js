module.exports = {
  views: function() {
    console.log('  Views will automatically generate the associated controllers + templates');
    console.log(' ');
    console.log('  If you wish to add more actions to your view, beyond the default \'index\' action');
    console.log('  you may pass additional arguments to the generator like so');
    console.log(' ');
    console.log('      $ rendr g view action1 action2 action3');
    console.log(' ');
    console.log('  Additionally, when called from the command-line');
    console.log(' ');
    console.log('      $ rendr g view');
    console.log('      and');
    console.log('      $ rendr g controller');
    console.log(' ');
    console.log('  are functionaly the same, \'controller\' is provided as a convience');
    console.log(' ');
  }
};