var s = require('string'),
    i = require('i')();

/*
 * Str fns
 */

exports.capitalize = function(str) {
  return s(str).capitalize().s;
};

exports.camelize = function(str) {
  return s(str).humanize().slugify().camelize().s;
};

exports.capCamelize = function(str) {
  return s(str).humanize().slugify().capitalize().camelize().s;
};

exports.dasherize = function(str) {
  return s(str).humanize().slugify().s;
};

exports.humanize = function(str) {
  return s(str).humanize().s;
};

exports.underscore = function(str) {
  return s(this.camelize(str)).underscore().s;
};

exports.pluralize = function(str) {
  return i.pluralize(str);
};