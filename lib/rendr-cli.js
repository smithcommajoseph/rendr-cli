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
  // .option('-c, --coffee', 'generators in Coffeescript')
  .option('-u, --url <url>', 'Model url')
  .option('-i, --idAttribute <id>', 'Model idAttribute')
  .option('-a, --apiHost <host>', 'Model apiHost')
  .option('n, new <projname>', 'Creates a new project')
  .option('g, generate <generator> <name>', 'Generate a model or view');

cli.on('--help', function(){
  cliCopy.views();
});

cli.parse(process.argv);

generator = BaseGenerator.getGenerator(cli);
generator.generate();