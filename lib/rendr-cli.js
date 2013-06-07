#!/usr/bin/env node

/*
 * render-cli
 * https://github.com/technicolorenvy/rendr-cli
 *
 * Copyright (c) 2013 Joseph (Jos) Smith
 * Licensed under the MIT license.
 */

var version = require('../package').version,
    cli = require('commander'),
    BaseGenerator = require('./generators/base_generator'),
    generator;

cli
  .version(version)
  // .option('-c, --coffee', 'generators in Coffeescript')
  .option('n, new <projname>', 'Creates a new project')
  .option('g, generate <generator> <name>', 'Generate a model or view');

cli.on('--help', function(){
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
});

cli.parse(process.argv);

generator = BaseGenerator.getGenerator(cli);
generator.generate();