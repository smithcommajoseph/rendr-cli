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
    generator = require('./generators/generator'),
    thing;

cli
  .version(version)
  .option('n, new <projname>', 'Create some new stuff')
  .option('g, generate <generator> <name>', 'Generate things')
  .option('-c, --coffee', 'Things in Coffeescript')
  .parse(process.argv);

thing = generator(cli);

// some debugging biz here...
console.log(thing.generatorName);
console.log(thing.lang);
console.log(thing.args);
console.log(cli.args);