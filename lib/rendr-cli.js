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
  .option('n, new <projname>', 'Create some new stuff')
  .option('g, generate <generator> <name>', 'Generate generators')
  .option('-c, --coffee', 'generators in Coffeescript')
  .parse(process.argv);

generator = BaseGenerator.getGenerator(cli);

// some debugging biz here...
console.log(generator.generatorDir);
console.log(generator.generatorName);
console.log(generator.templates);
console.log(generator.lang);
console.log(generator.opts);
console.log(generator.args);
console.log(generator.actions);
console.log(cli.args);

generator.generate();