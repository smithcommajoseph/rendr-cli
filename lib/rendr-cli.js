#!/usr/bin/env node

/*
 * render-cli
 * https://github.com/technicolorenvy/rendr-cli
 *
 * Copyright (c) 2013 Joseph (Jos) Smith
 * Licensed under the MIT license.
 */

var version = require('../package').version,
    cliCopy = require('./cli-help-copy'),
    cli = require('commander'),
    BaseGenerator = require('./generators/base_generator'),
    generator;

cli
  .version(version)
  .usage('COMMAND [options]')
  // .option('-c, --coffee', 'generators in Coffeescript') //coming soon!
  .option('-u, --url <url>', 'Set a url (only evaluated when generating a model)')
  .option('-i, --idAttribute <idAttribute>', 'Set an idAttribute (only evaluated when generating a model)')
  .option('-a, --apiHost <apiHost>', 'Set an apiHost (only evaluated when generating a model)')
  .option('--noTemplates', 'Do not generate templates (only evaluated when generating a view)')
  .option('n, new <name>', 'Creates a new Rendr project with <name>')
  .option('g, generate <g> <name>', 'Generate a <model, view> with <name>');

cli.on('--help', function(){
  cliCopy.description();
  cliCopy.models();
  cliCopy.views();
  cliCopy.controllers();
  cliCopy.scaffolds();
});

cli.parse(process.argv);

generator = BaseGenerator.getGenerator(cli);
generator.generate();