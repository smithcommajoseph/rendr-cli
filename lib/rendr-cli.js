#!/usr/bin/env node

/*
 * thing-stuff
 * https://github.com/technicolorenvy/rendr-cli
 *
 * Copyright (c) 2013 Joseph (Jos) Smith
 * Licensed under the MIT license.
 */

var program = require('commander');

program
	.version('0.0.1')
	.option('n, new [projname]', 'Create some new stuff')
	.option('g, generate <generator> [name]', 'Generate things')
	.parse(process.argv);

if (program.new) console.log('creating new project name %s', program.new);
if (program.generate) console.log('generating %s named %s', program.generate, program.args[0]);
	