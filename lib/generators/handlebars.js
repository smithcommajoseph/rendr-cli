var Handlebars = require('handlebars');

Handlebars.registerHelper("foreach",function(arr,options) {
  if(options.inverse && !arr.length)
    return options.inverse(this);

  return arr.map(function(item,index) {
    item.$index = index;
    item.$first = index === 0;
    item.$last  = index === arr.length-1;
    return options.fn(item);
  }).join('');
});

module.exports = Handlebars;