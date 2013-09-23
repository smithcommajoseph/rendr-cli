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
    generator,

    VALID_COMMANDS = ['new', 'generate'];

cli
  .version(version)
  .usage('<command> [options]')
  .option('-c, --coffee', 'generators in Coffeescript')
  .option('-u, --url <url>', 'Set a url (evaluated when generating a model or collection)')
  .option('-a, --api <api>', 'Set an apiHost (evaluated when generating a model or collection)')
  .option('-i, --idAttribute <idAttribute>', 'Set an idAttribute (evaluated when generating a model)')
  .option('--addCollection', 'Will generate the corresponding collection (evaluated when generating a model)')
  .option('--noTemplates', 'Do not generate templates (evaluated when generating a view)');

cli.on('--help', function(){
  console.log('  Commands: ');
  console.log('     ');
  console.log('     n, new <appName>                          Creates a new Rendr project');
  console.log('     g, generate <component> <name> [options]  Generate a component with <name>');
  // console.log('     d, destroy <component> <name> [options]   Destroy a component with <name>');
  console.log('     ');
  process.exit();
});

cli.parse(process.argv);

// args
var args = cli.args.slice(1);
// command
var cmd = cli.args[0];
// aliases
if ('n' == cmd) cmd = 'new';
// if ('d' == cmd) cmd = 'destroy';
if ('g' == cmd) cmd = 'generate';

if (!!~VALID_COMMANDS.indexOf(cmd)) {
  generator = BaseGenerator.getGenerator(cmd, args, cli);
  generator[cmd]();
} else {
  BaseGenerator.prototype.throwError('rendr.' + cmd, 'is not a valid rendr command');
}
