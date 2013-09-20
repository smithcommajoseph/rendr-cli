var _ = require('underscore'),
    s = require('string'),
    i = require('i')(),
    fs = require('fs'),
    colors = require('colors'),
    BaseCliOb;

function noop() {}

BaseCliOb = module.exports = function BaseCliOb() {
  this.initialize.apply(this, arguments);
};

BaseCliOb.prototype.initialize = noop;

BaseCliOb.prototype.logToConsole = function logToConsole (type, cmd, desc, deets) {
  var pre = 'rendr',
      copy;
  desc = !!desc ? desc.magenta : '';
  deets = deets || '';
  switch(type){
    case 'success':
      cmd = cmd.green;
      break;
    case 'error':
      cmd = cmd.red.inverse;
      break;
    case 'warn':
      cmd = cmd.yellow;
      break;
  }
  copy = [pre, cmd, desc, deets].join(' ');
  console.log(copy);
};

// not really a 'throw', but does kill the process w/ a readable err message
BaseCliOb.prototype.throwError = function throwError (desc, deets) {
  this.logToConsole('error', 'err', desc, deets);
  process.exit();
};

BaseCliOb.prototype.dirExists = function dirExists (dir) {
  var retVal = false;
  try { fs.statSync(dir).isDirectory(); retVal = true;}
  catch (er) { }
  return retVal;
};

BaseCliOb.prototype.isFile = function isFile (dir) {
  var retVal = false;
  try { fs.statSync(dir).isFile(); retVal = true;}
  catch (er) { }
  return retVal;
};

BaseCliOb.prototype.createDirectory = function createDirectory (dir) {
  try{
    fs.mkdirSync(dir);
    if (this.verbose) this.logToConsole('success', 'generating', 'dir ', dir);
  }
  catch(err) {
    this.logToConsole('error', 'failed to generate', 'dir ', dir);
    console.log(err); //go ahead and give the full error
  }
};

BaseCliOb.prototype.createFile = function createFile (file, data) {
  try{
    fs.writeFileSync(file, data);
    if (this.verbose) this.logToConsole('success', 'generating', 'file', file);
  }
  catch(err){
    this.logToConsole('error', 'failed to generate', 'file ', file);
    console.log(err); //go ahead and give the full error 
  }
};

/*
 * Str fns
 */

BaseCliOb.prototype.capitalize = function capitalize (str) {
  return s(str).capitalize().s;
};

BaseCliOb.prototype.camelize = function camelize (str) {
  return s(str).humanize().slugify().camelize().s;
};

BaseCliOb.prototype.capCamelize = function capCamelize (str) {
  return s(str).humanize().slugify().capitalize().camelize().s;
};

BaseCliOb.prototype.dasherize = function dasherize (str) {
  return s(str).humanize().slugify().s;
};

BaseCliOb.prototype.humanize = function humanize (str) {
  return s(str).humanize().s;
};

BaseCliOb.prototype.underscore = function underscore (str) {
  return s(this.camelize(str)).underscore().s;
};

BaseCliOb.prototype.pluralize = function pluralize (str) {
  return i.pluralize(str);
};

/*
 * Class methods
 */

BaseCliOb.extend = function extend (protoProps, staticProps) {
  var parent = this;
  var child;

  if (protoProps && _.has(protoProps, 'constructor')) {
    child = protoProps.constructor;
  } else {
    child = function(){ return parent.apply(this, arguments); };
  }

  _.extend(child, parent, staticProps);

  var Surrogate = function(){ this.constructor = child; };
  Surrogate.prototype = parent.prototype;
  child.prototype = new Surrogate();

  if (protoProps) _.extend(child.prototype, protoProps);

  child.__super__ = parent.prototype;

  return child;
};
