var s = require('string'),
    i = require('i')();

/*
 * Str fns
 */

exports.capitalize = function capitalize (str) {
  return s(str).capitalize().s;
};

exports.camelize = function camelize (str) {
  return s(str).humanize().slugify().camelize().s;
};

exports.capCamelize = function capCamelize (str) {
  return s(str).humanize().slugify().capitalize().camelize().s;
};

exports.dasherize = function dasherize (str) {
  return s(str).humanize().slugify().s;
};

exports.humanize = function humanize (str) {
  return s(str).humanize().s;
};

exports.underscore = function underscore (str) {
  return s(this.camelize(str)).underscore().s;
};

exports.pluralize = function pluralize (str) {
  return i.pluralize(str);
};