#
#    http://www.JSON.org/json2.js
#    2011-02-23
#
#    Public Domain.
#
#    NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.
#
#    See http://www.JSON.org/js.html
#
#
#    This code should be minified before deployment.
#    See http://javascript.crockford.com/jsmin.html
#
#    USE YOUR OWN COPY. IT IS EXTREMELY UNWISE TO LOAD CODE FROM SERVERS YOU DO
#    NOT CONTROL.
#
#
#    This file creates a global JSON object containing two methods: stringify
#    and parse.
#
#        JSON.stringify(value, replacer, space)
#            value       any JavaScript value, usually an object or array.
#
#            replacer    an optional parameter that determines how object
#                        values are stringified for objects. It can be a
#                        function or an array of strings.
#
#            space       an optional parameter that specifies the indentation
#                        of nested structures. If it is omitted, the text will
#                        be packed without extra whitespace. If it is a number,
#                        it will specify the number of spaces to indent at each
#                        level. If it is a string (such as '\t' or '&nbsp;'),
#                        it contains the characters used to indent at each level.
#
#            This method produces a JSON text from a JavaScript value.
#
#            When an object value is found, if the object contains a toJSON
#            method, its toJSON method will be called and the result will be
#            stringified. A toJSON method does not serialize: it returns the
#            value represented by the name/value pair that should be serialized,
#            or undefined if nothing should be serialized. The toJSON method
#            will be passed the key associated with the value, and this will be
#            bound to the value
#
#            For example, this would serialize Dates as ISO strings.
#
#                Date.prototype.toJSON = function (key) {
#                    function f(n) {
#                        // Format integers to have at least two digits.
#                        return n < 10 ? '0' + n : n;
#                    }
#
#                    return this.getUTCFullYear()   + '-' +
#                         f(this.getUTCMonth() + 1) + '-' +
#                         f(this.getUTCDate())      + 'T' +
#                         f(this.getUTCHours())     + ':' +
#                         f(this.getUTCMinutes())   + ':' +
#                         f(this.getUTCSeconds())   + 'Z';
#                };
#
#            You can provide an optional replacer method. It will be passed the
#            key and value of each member, with this bound to the containing
#            object. The value that is returned from your method will be
#            serialized. If your method returns undefined, then the member will
#            be excluded from the serialization.
#
#            If the replacer parameter is an array of strings, then it will be
#            used to select the members to be serialized. It filters the results
#            such that only members with keys listed in the replacer array are
#            stringified.
#
#            Values that do not have JSON representations, such as undefined or
#            functions, will not be serialized. Such values in objects will be
#            dropped; in arrays they will be replaced with null. You can use
#            a replacer function to replace those with JSON values.
#            JSON.stringify(undefined) returns undefined.
#
#            The optional space parameter produces a stringification of the
#            value that is filled with line breaks and indentation to make it
#            easier to read.
#
#            If the space parameter is a non-empty string, then that string will
#            be used for indentation. If the space parameter is a number, then
#            the indentation will be that many spaces.
#
#            Example:
#
#            text = JSON.stringify(['e', {pluribus: 'unum'}]);
#            // text is '["e",{"pluribus":"unum"}]'
#
#
#            text = JSON.stringify(['e', {pluribus: 'unum'}], null, '\t');
#            // text is '[\n\t"e",\n\t{\n\t\t"pluribus": "unum"\n\t}\n]'
#
#            text = JSON.stringify([new Date()], function (key, value) {
#                return this[key] instanceof Date ?
#                    'Date(' + this[key] + ')' : value;
#            });
#            // text is '["Date(---current time---)"]'
#
#
#        JSON.parse(text, reviver)
#            This method parses a JSON text to produce an object or array.
#            It can throw a SyntaxError exception.
#
#            The optional reviver parameter is a function that can filter and
#            transform the results. It receives each of the keys and values,
#            and its return value is used instead of the original value.
#            If it returns what it received, then the structure is not modified.
#            If it returns undefined then the member is deleted.
#
#            Example:
#
#            // Parse the text. Values that look like ISO date strings will
#            // be converted to Date objects.
#
#            myData = JSON.parse(text, function (key, value) {
#                var a;
#                if (typeof value === 'string') {
#                    a =
#/^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2}(?:\.\d*)?)Z$/.exec(value);
#                    if (a) {
#                        return new Date(Date.UTC(+a[1], +a[2] - 1, +a[3], +a[4],
#                            +a[5], +a[6]));
#                    }
#                }
#                return value;
#            });
#
#            myData = JSON.parse('["Date(09/09/2001)"]', function (key, value) {
#                var d;
#                if (typeof value === 'string' &&
#                        value.slice(0, 5) === 'Date(' &&
#                        value.slice(-1) === ')') {
#                    d = new Date(value.slice(5, -1));
#                    if (d) {
#                        return d;
#                    }
#                }
#                return value;
#            });
#
#
#    This is a reference implementation. You are free to copy, modify, or
#    redistribute.
#

#jslint evil: true, strict: false, regexp: false 

#members "", "\b", "\t", "\n", "\f", "\r", "\"", JSON, "\\", apply,
#    call, charCodeAt, getUTCDate, getUTCFullYear, getUTCHours,
#    getUTCMinutes, getUTCMonth, getUTCSeconds, hasOwnProperty, join,
#    lastIndex, length, parse, prototype, push, replace, slice, stringify,
#    test, toJSON, toString, valueOf
#

# Create a JSON object only if one does not already exist. We create the
# methods in a closure to avoid creating global variables.
JSON = undefined
JSON = {}  unless JSON
(->
  f = (n) ->
    
    # Format integers to have at least two digits.
    (if n < 10 then "0" + n else n)
  # table of character substitutions
  quote = (string) ->
    
    # If the string contains no control characters, no quote characters, and no
    # backslash characters, then we can safely slap some quotes around it.
    # Otherwise we must also replace the offending characters with safe escape
    # sequences.
    escapable.lastIndex = 0
    (if escapable.test(string) then "\"" + string.replace(escapable, (a) ->
      c = meta[a]
      (if typeof c is "string" then c else "\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4))
    ) + "\"" else "\"" + string + "\"")
  str = (key, holder) ->
    
    # Produce a string from holder[key].
    i = undefined # The loop counter.
    k = undefined
    v = undefined
    length = undefined
    # The member key.
    # The member value.
    mind = gap
    partial = undefined
    value = holder[key]
    
    # If the value has a toJSON method, call it to obtain a replacement value.
    value = value.toJSON(key)  if value and typeof value is "object" and typeof value.toJSON is "function"
    
    # If we were called with a replacer function, then call the replacer to
    # obtain a replacement value.
    value = rep.call(holder, key, value)  if typeof rep is "function"
    
    # What happens next depends on the value's type.
    switch typeof value
      when "string"
        quote value
      when "number"
        
        # JSON numbers must be finite. Encode non-finite numbers as null.
        (if isFinite(value) then String(value) else "null")
      when "boolean", "null"
        
        # If the value is a boolean or null, convert it to a string. Note:
        # typeof null does not produce 'null'. The case is included here in
        # the remote chance that this gets fixed someday.
        String value
      
      # If the type is 'object', we might be dealing with an object or an array or
      # null.
      when "object"
        
        # Due to a specification blunder in ECMAScript, typeof null is 'object',
        # so watch out for that case.
        return "null"  unless value
        
        # Make an array to hold the partial results of stringifying this object value.
        gap += indent
        partial = []
        
        # Is the value an array?
        if Object::toString.apply(value) is "[object Array]"
          
          # The value is an array. Stringify every element. Use null as a placeholder
          # for non-JSON values.
          length = value.length
          i = 0
          while i < length
            partial[i] = str(i, value) or "null"
            i += 1
          
          # Join all of the elements together, separated with commas, and wrap them in
          # brackets.
          v = (if partial.length is 0 then "[]" else (if gap then "[\n" + gap + partial.join(",\n" + gap) + "\n" + mind + "]" else "[" + partial.join(",") + "]"))
          gap = mind
          return v
        
        # If the replacer is an array, use it to select the members to be stringified.
        if rep and typeof rep is "object"
          length = rep.length
          i = 0
          while i < length
            if typeof rep[i] is "string"
              k = rep[i]
              v = str(k, value)
              partial.push quote(k) + ((if gap then ": " else ":")) + v  if v
            i += 1
        else
          
          # Otherwise, iterate through all of the keys in the object.
          for k of value
            if Object::hasOwnProperty.call(value, k)
              v = str(k, value)
              partial.push quote(k) + ((if gap then ": " else ":")) + v  if v
        
        # Join all of the member texts together, separated with commas,
        # and wrap them in braces.
        v = (if partial.length is 0 then "{}" else (if gap then "{\n" + gap + partial.join(",\n" + gap) + "\n" + mind + "}" else "{" + partial.join(",") + "}"))
        gap = mind
        v
  "use strict"
  if typeof Date::toJSON isnt "function"
    Date::toJSON = (key) ->
      (if isFinite(@valueOf()) then @getUTCFullYear() + "-" + f(@getUTCMonth() + 1) + "-" + f(@getUTCDate()) + "T" + f(@getUTCHours()) + ":" + f(@getUTCMinutes()) + ":" + f(@getUTCSeconds()) + "Z" else null)

    String::toJSON = Number::toJSON = Boolean::toJSON = (key) ->
      @valueOf()
  cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g
  escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g
  gap = undefined
  indent = undefined
  meta =
    "\b": "\\b"
    "\t": "\\t"
    "\n": "\\n"
    "\f": "\\f"
    "\r": "\\r"
    "\"": "\\\""
    "\\": "\\\\"

  rep = undefined
  
  # If the JSON object does not yet have a stringify method, give it one.
  if typeof JSON.stringify isnt "function"
    JSON.stringify = (value, replacer, space) ->
      
      # The stringify method takes a value and an optional replacer, and an optional
      # space parameter, and returns a JSON text. The replacer can be a function
      # that can replace values, or an array of strings that will select the keys.
      # A default replacer method can be provided. Use of the space parameter can
      # produce text that is more easily readable.
      i = undefined
      gap = ""
      indent = ""
      
      # If the space parameter is a number, make an indent string containing that
      # many spaces.
      if typeof space is "number"
        i = 0
        while i < space
          indent += " "
          i += 1
      
      # If the space parameter is a string, it will be used as the indent string.
      else indent = space  if typeof space is "string"
      
      # If there is a replacer, it must be a function or an array.
      # Otherwise, throw an error.
      rep = replacer
      throw new Error("JSON.stringify")  if replacer and typeof replacer isnt "function" and (typeof replacer isnt "object" or typeof replacer.length isnt "number")
      
      # Make a fake root object containing our value under the key of ''.
      # Return the result of stringifying the value.
      str "",
        "": value

  
  # If the JSON object does not yet have a parse method, give it one.
  if typeof JSON.parse isnt "function"
    JSON.parse = (text, reviver) ->
      
      # The parse method takes a text and an optional reviver function, and returns
      # a JavaScript value if the text is a valid JSON text.
      
      # Nice little hack from your friends at Airbnb - this is how all native implementations
      # of JSON.parse work.
      walk = (holder, key) ->
        
        # The walk method is used to recursively walk the resulting structure so
        # that modifications can be made.
        k = undefined
        v = undefined
        value = holder[key]
        if value and typeof value is "object"
          for k of value
            if Object::hasOwnProperty.call(value, k)
              v = walk(value, k)
              if v isnt `undefined`
                value[k] = v
              else
                delete value[k]
        reviver.call holder, key, value
      return null  unless text?
      j = undefined
      
      # Parsing happens in four stages. In the first stage, we replace certain
      # Unicode characters with escape sequences. JavaScript handles many characters
      # incorrectly, either silently deleting them, or treating them as line endings.
      text = String(text)
      cx.lastIndex = 0
      if cx.test(text)
        text = text.replace(cx, (a) ->
          "\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4)
        )
      
      # In the second stage, we run the text against regular expressions that look
      # for non-JSON patterns. We are especially concerned with '()' and 'new'
      # because they can cause invocation, and '=' because it can cause mutation.
      # But just to be safe, we want to reject all unexpected forms.
      
      # We split the second stage into 4 regexp operations in order to work around
      # crippling inefficiencies in IE's and Safari's regexp engines. First we
      # replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
      # replace all simple value tokens with ']' characters. Third, we delete all
      # open brackets that follow a colon or comma or that begin the text. Finally,
      # we look to see that the remaining characters are only whitespace or ']' or
      # ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.
      if /^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, "@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]").replace(/(?:^|:|,)(?:\s*\[)+/g, ""))
        
        # In the third stage we use the eval function to compile the text into a
        # JavaScript structure. The '{' operator is subject to a syntactic ambiguity
        # in JavaScript: it can begin a block or an object literal. We wrap the text
        # in parens to eliminate the ambiguity.
        j = eval_("(" + text + ")")
        
        # In the optional fourth stage, we recursively walk the new structure, passing
        # each name/value pair to a reviver function for possible transformation.
        return (if typeof reviver is "function" then walk(
          "": j
        , "") else j)
      
      # If the text is not JSON parseable, then a SyntaxError is thrown.
      throw new SyntaxError("JSON.parse")
)()
