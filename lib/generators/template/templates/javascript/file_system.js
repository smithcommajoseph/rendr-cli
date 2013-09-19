var fs = require('fs');

exports.dirExists = function(dir) {
  var retVal = false;
  try { fs.statSync(dir).isDirectory(); retVal = true;}
  catch (er) { }
  return retVal;
};

exports.isFile = function(dir) {
  var retVal = false;
  try { fs.statSync(dir).isFile(); retVal = true;}
  catch (er) { }
  return retVal;
};
