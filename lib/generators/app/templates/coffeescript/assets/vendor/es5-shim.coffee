# Copyright 2009-2012 by contributors, MIT License
# vim: ts=4 sts=4 sw=4 expandtab

# Module systems magic dance
((definition) ->
  
  # RequireJS
  if typeof define is "function"
    define definition
  
  # YUI3
  else if typeof YUI is "function"
    YUI.add "es5", definition
  
  # CommonJS and <script>
  else
    definition()
) ->
  
  ###
  Brings an environment as close to ECMAScript 5 compliance
  as is possible with the facilities of erstwhile engines.
  
  Annotated ES5: http://es5.github.com/ (specific links below)
  ES5 Spec: http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf
  Required reading: http://javascriptweblog.wordpress.com/2011/12/05/extending-javascript-natives/
  ###
  
  #
  # Function
  # ========
  #
  
  # ES-5 15.3.4.5
  # http://es5.github.com/#x15.3.4.5
  Empty = ->
  # .length is 1
  # 1. Let Target be the this value.
  
  # 2. If IsCallable(Target) is false, throw a TypeError exception.
  
  # 3. Let A be a new (possibly empty) internal list of all of the
  #   argument values provided after thisArg (arg1, arg2 etc), in order.
  # XXX slicedArgs will stand in for "A" if used
  # for normal call
  # 4. Let F be a new native ECMAScript object.
  # 11. Set the [[Prototype]] internal property of F to the standard
  #   built-in Function prototype object as specified in 15.3.3.1.
  # 12. Set the [[Call]] internal property of F as described in
  #   15.3.4.5.1.
  # 13. Set the [[Construct]] internal property of F as described in
  #   15.3.4.5.2.
  # 14. Set the [[HasInstance]] internal property of F as described in
  #   15.3.4.5.3.
  
  # 15.3.4.5.2 [[Construct]]
  # When the [[Construct]] internal method of a function object,
  # F that was created using the bind function is called with a
  # list of arguments ExtraArgs, the following steps are taken:
  # 1. Let target be the value of F's [[TargetFunction]]
  #   internal property.
  # 2. If target has no [[Construct]] internal method, a
  #   TypeError exception is thrown.
  # 3. Let boundArgs be the value of F's [[BoundArgs]] internal
  #   property.
  # 4. Let args be a new list containing the same values as the
  #   list boundArgs in the same order followed by the same
  #   values as the list ExtraArgs in the same order.
  # 5. Return the result of calling the [[Construct]] internal
  #   method of target providing args as the arguments.
  
  # 15.3.4.5.1 [[Call]]
  # When the [[Call]] internal method of a function object, F,
  # which was created using the bind function is called with a
  # this value and a list of arguments ExtraArgs, the following
  # steps are taken:
  # 1. Let boundArgs be the value of F's [[BoundArgs]] internal
  #   property.
  # 2. Let boundThis be the value of F's [[BoundThis]] internal
  #   property.
  # 3. Let target be the value of F's [[TargetFunction]] internal
  #   property.
  # 4. Let args be a new list containing the same values as the
  #   list boundArgs in the same order followed by the same
  #   values as the list ExtraArgs in the same order.
  # 5. Return the result of calling the [[Call]] internal method
  #   of target providing boundThis as the this value and
  #   providing args as the arguments.
  
  # equiv: target.call(this, ...boundArgs, ...args)
  
  # Clean up dangling references.
  
  # XXX bound.length is never writable, so don't even try
  #
  # 15. If the [[Class]] internal property of Target is "Function", then
  #     a. Let L be the length property of Target minus the length of A.
  #     b. Set the length own property of F to either 0 or L, whichever is
  #       larger.
  # 16. Else set the length own property of F to 0.
  # 17. Set the attributes of the length own property of F to the values
  #   specified in 15.3.5.1.
  
  # TODO
  # 18. Set the [[Extensible]] internal property of F to true.
  
  # TODO
  # 19. Let thrower be the [[ThrowTypeError]] function Object (13.2.3).
  # 20. Call the [[DefineOwnProperty]] internal method of F with
  #   arguments "caller", PropertyDescriptor {[[Get]]: thrower, [[Set]]:
  #   thrower, [[Enumerable]]: false, [[Configurable]]: false}, and
  #   false.
  # 21. Call the [[DefineOwnProperty]] internal method of F with
  #   arguments "arguments", PropertyDescriptor {[[Get]]: thrower,
  #   [[Set]]: thrower, [[Enumerable]]: false, [[Configurable]]: false},
  #   and false.
  
  # TODO
  # NOTE Function objects created using Function.prototype.bind do not
  # have a prototype property or the [[Code]], [[FormalParameters]], and
  # [[Scope]] internal properties.
  # XXX can't delete prototype in pure-js.
  
  # 22. Return F.
  
  # Shortcut to an often accessed properties, in order to avoid multiple
  # dereference that costs universally.
  # _Please note: Shortcuts are defined after `Function.prototype.bind` as we
  # us it in defining shortcuts.
  
  # Having a toString local variable name breaks in Opera so use _toString.
  
  # If JS engine supports accessors creating shortcuts.
  
  #
  # Array
  # =====
  #
  
  # ES5 15.4.4.12
  # http://es5.github.com/#x15.4.4.12
  # Default value for second param
  # [bugfix, ielt9, old browsers]
  # IE < 9 bug: [1,2].splice(0).join("") == "" but should be "12"
  # test IE < 9 to splice bug - see issue #138
  #20
  # add one element
  # has right splice implementation without bugs
  
  # else {
  #    IE8 bug
  # }
  #IE 6/7
  #IE8
  # default
  # default
  # tiny optimisation #1
  # tiny optimisation #2
  
  # Array.prototype.splice implementation
  # delete part
  # right part
  # left part
  
  # delete all items from this array and replace it to 'left part' + _Array_slice_.call(arguments, 2) + 'right part'
  
  # ES5 15.4.4.12
  # http://es5.github.com/#x15.4.4.13
  # Return len+argCount.
  # [bugfix, ielt8]
  # IE < 8 bug: [].unshift(0) == undefined but should be "1"
  
  # ES5 15.4.3.2
  # http://es5.github.com/#x15.4.3.2
  # https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/isArray
  
  # The IsCallable() check in the Array functions
  # has been replaced with a strict check on the
  # internal class of the object to trap cases where
  # the provided function was actually a regular
  # expression literal, which in V8 and
  # JavaScriptCore is a typeof "function".  Only in
  # V8 are regular expression literals permitted as
  # reduce parameters, so it is desirable in the
  # general case for the shim to match the more
  # strict and common behavior of rejecting regular
  # expressions.
  
  # ES5 15.4.4.18
  # http://es5.github.com/#x15.4.4.18
  # https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/array/forEach
  
  # Check failure of by-index access of string characters (IE < 9)
  # and failure of `0 in boxedString` (Rhino)
  #, thisp
  
  # If no callback function or if callback is not a callable function
  # TODO message
  
  # Invoke the callback function with call, passing arguments:
  # context, property value, property key, thisArg object
  # context
  
  # ES5 15.4.4.19
  # http://es5.github.com/#x15.4.4.19
  # https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/map
  #, thisp
  
  # If no callback function or if callback is not a callable function
  
  # ES5 15.4.4.20
  # http://es5.github.com/#x15.4.4.20
  # https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/filter
  #, thisp 
  
  # If no callback function or if callback is not a callable function
  
  # ES5 15.4.4.16
  # http://es5.github.com/#x15.4.4.16
  # https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/every
  #, thisp 
  
  # If no callback function or if callback is not a callable function
  
  # ES5 15.4.4.17
  # http://es5.github.com/#x15.4.4.17
  # https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/some
  #, thisp 
  
  # If no callback function or if callback is not a callable function
  
  # ES5 15.4.4.21
  # http://es5.github.com/#x15.4.4.21
  # https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/reduce
  #, initial
  
  # If no callback function or if callback is not a callable function
  
  # no value to return if no initial value and an empty array
  
  # if array contains no values, no initial value to return
  
  # ES5 15.4.4.22
  # http://es5.github.com/#x15.4.4.22
  # https://developer.mozilla.org/en/Core_JavaScript_1.5_Reference/Objects/Array/reduceRight
  #, initial
  
  # If no callback function or if callback is not a callable function
  
  # no value to return if no initial value, empty array
  
  # if array contains no values, no initial value to return
  
  # ES5 15.4.4.14
  # http://es5.github.com/#x15.4.4.14
  # https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/indexOf
  #, fromIndex 
  
  # handle negative indices
  
  # ES5 15.4.4.15
  # http://es5.github.com/#x15.4.4.15
  # https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Array/lastIndexOf
  #, fromIndex 
  
  # handle negative indices
  
  #
  # Object
  # ======
  #
  
  # ES5 15.2.3.14
  # http://es5.github.com/#x15.2.3.14
  
  # http://whattheheadsaid.com/2010/10/a-safer-object-keys-compatibility-implementation
  
  #
  # Date
  # ====
  #
  
  # ES5 15.9.5.43
  # http://es5.github.com/#x15.9.5.43
  # This function returns a String value represent the instance in time
  # represented by this Date object. The format of the String is the Date Time
  # string format defined in 15.9.1.15. All fields are present in the String.
  # The time zone is always UTC, denoted by the suffix Z. If the time value of
  # this object is not a finite Number a RangeError exception is thrown.
  
  # see https://github.com/kriskowal/es5-shim/issues/111
  
  # the date time string format is specified in 15.9.1.15.
  
  # pad months, days, hours, minutes, and seconds to have two
  # digits.
  
  # pad milliseconds to have three digits.
  
  # ES5 15.9.5.44
  # http://es5.github.com/#x15.9.5.44
  # This function provides a String representation of a Date object for use by
  # JSON.stringify (15.12.3).
  # generic
  
  # When the toJSON method is called with argument key, the following
  # steps are taken:
  
  # 1.  Let O be the result of calling ToObject, giving it the this
  # value as its argument.
  # 2. Let tv be toPrimitive(O, hint Number).
  
  # 3. If tv is a Number and is not finite, return null.
  
  # 4. Let toISO be the result of calling the [[Get]] internal method of
  # O with argument "toISOString".
  
  # 5. If IsCallable(toISO) is false, throw a TypeError exception.
  
  # 6. Return the result of calling the [[Call]] internal method of
  #  toISO with O as the this value and an empty argument list.
  
  # NOTE 1 The argument is ignored.
  
  # NOTE 2 The toJSON function is intentionally generic; it does not
  # require that its this value be a Date object. Therefore, it can be
  # transferred to other kinds of objects for use as a method. However,
  # it does require that any such object have a toISOString method. An
  # object is free to use the argument key to filter its
  # stringification.
  
  # ES5 15.9.4.2
  # http://es5.github.com/#x15.9.4.2
  # based on work shared by Daniel Friesen (dantman)
  # http://gist.github.com/303249
  
  # XXX global assignment won't work in embeddings that use
  # an alternate object for the context.
  
  # Date.length === 7
  # isString(Y)
  # We explicitly pass it through parse:
  
  # We have to manually make calls depending on argument
  # length here
  
  # Prevent mixups with unfixed Date object
  
  # 15.9.1.15 Date Time String Format.
  # four-digit year capture or sign +
  # 6-digit extended year
  # optional month capture
  # optional day capture
  # capture hours:minutes:seconds.milliseconds
  # hours capture
  # minutes capture
  # optional :seconds.milliseconds
  # seconds capture
  # milliseconds capture
  # capture UTC offset component
  # UTC capture
  # offset specifier +/-hours:minutes
  # sign capture
  # hours offset capture
  # minutes offset capture
  
  # Copy any custom methods a 3rd party library may have added
  
  # Copy "native" methods explicitly; they may be non-enumerable
  
  # Upgrade Date.parse to handle simplified ISO 8601 strings
  
  # parse months, days, hours, minutes, seconds, and milliseconds
  # provide default values if necessary
  # parse the UTC offset component
  
  # When time zone is missed, local offset should be used
  # (ES 5.1 bug)
  # see https://bugs.ecmascript.org/show_bug.cgi?id=112
  # detect invalid offsets
  
  # ES5 15.9.4.4
  # http://es5.github.com/#x15.9.4.4
  
  #
  # Number
  # ======
  #
  
  # ES5.1 15.7.4.5
  # http://es5.github.com/#x15.7.4.5
  
  # Hide these variables and functions
  
  # Test for NaN and round fractionDigits down
  
  # Test for NaN
  
  # If it is too big or small, return the string value of the number
  
  # 1e-21 < x < 1e21
  # -70 < log2(x) < 70
  # Math.pow(2, 52);
  
  # -18 < e < 122
  # x = z / 2 ^ e
  
  #
  # String
  # ======
  #
  
  # ES5 15.5.4.14
  # http://es5.github.com/#x15.5.4.14
  
  # [bugfix, IE lt 9, firefox 4, Konqueror, Opera, obscure browsers]
  # Many browsers do not split properly with regular expressions or they
  # do not perform the split correctly under obscure conditions.
  # See http://blog.stevenlevithan.com/archives/cross-browser-split
  # I've tested in many browsers and this seems to cover the deviant ones:
  #    'ab'.split(/(?:ab)*/) should be ["", ""], not [""]
  #    '.'.split(/(.?)(.?)/) should be ["", ".", "", ""], not ["", ""]
  #    'tesst'.split(/(s)*/) should be ["t", undefined, "e", "s", "t"], not
  #       [undefined, "t", undefined, "e", ...]
  #    ''.split(/.?/) should be [], not [""]
  #    '.'.split(/()()/) should be ["."], not ["", "", "."]
  # NPCG: nonparticipating capturing group
  
  # If `separator` is not a regex, use native split
  # Proposed for ES6
  # Firefox 3+
  
  # Make `global` and avoid `lastIndex` issues by working with a copy
  # Type-convert
  
  # Doesn't need flags gy, but they don't hurt
  
  # Values for `limit`, per the spec:
  #             * If undefined: 4294967295 // Math.pow(2, 32) - 1
  #             * If 0, Infinity, or NaN: 0
  #             * If positive number: limit = Math.floor(limit); if (limit > 4294967295) limit -= 4294967296;
  #             * If negative number: 4294967296 - Math.floor(Math.abs(limit))
  #             * If other: Type-convert, then use the above rules
  #             
  # Math.pow(2, 32) - 1
  # ToUint32(limit)
  
  # `separator.lastIndex` is not reliable cross-browser
  
  # Fix browsers whose `exec` methods don't consistently return `undefined` for
  # nonparticipating capturing groups
  # Avoid an infinite loop
  
  # [bugfix, chrome]
  # If separator is undefined, then the result array contains just one String,
  # which is the this value (converted to a String). If limit is not undefined,
  # then the output array is truncated so that it contains no more than limit
  # elements.
  # "0".split(undefined, 0) -> []
  
  # ECMA-262, 3rd B.2.3
  # Note an ECMAScript standart, although ECMAScript 3rd Edition has a
  # non-normative section suggesting uniform semantics and it should be
  # normalized across all browsers
  # [bugfix, IE lt 9] IE < 9 substr() with negative value not working in IE
  
  ###
  Get the substring of a string
  @param  {integer}  start   where to start the substring
  @param  {integer}  length  how many characters to return
  @return {string}
  ###
  
  # ES5 15.5.4.20
  # http://es5.github.com/#x15.5.4.20
  
  # http://blog.stevenlevithan.com/archives/faster-trim-javascript
  # http://perfectionkills.com/whitespace-deviations/
  
  #
  # Util
  # ======
  #
  
  # ES5 9.4
  # http://es5.github.com/#x9.4
  # http://jsperf.com/to-integer
  toInteger = (n) ->
    n = +n
    if n isnt n # isNaN
      n = 0
    else n = (n > 0 or -1) * Math.floor(Math.abs(n))  if n isnt 0 and n isnt (1 / 0) and n isnt -(1 / 0)
    n
  isPrimitive = (input) ->
    type = typeof input
    input is null or type is "undefined" or type is "boolean" or type is "number" or type is "string"
  toPrimitive = (input) ->
    val = undefined
    valueOf = undefined
    toString = undefined
    return input  if isPrimitive(input)
    valueOf = input.valueOf
    if typeof valueOf is "function"
      val = valueOf.call(input)
      return val  if isPrimitive(val)
    toString = input.toString
    if typeof toString is "function"
      val = toString.call(input)
      return val  if isPrimitive(val)
    throw new TypeError()
  unless Function::bind
    Function::bind = bind = (that) ->
      target = this
      throw new TypeError("Function.prototype.bind called on incompatible " + target)  unless typeof target is "function"
      args = _Array_slice_.call(arguments_, 1)
      bound = ->
        if this instanceof bound
          result = target.apply(this, args.concat(_Array_slice_.call(arguments_)))
          return result  if Object(result) is result
          this
        else
          target.apply that, args.concat(_Array_slice_.call(arguments_))

      if target::
        Empty:: = target::
        bound:: = new Empty()
        Empty:: = null
      bound
  call = Function::call
  prototypeOfArray = Array::
  prototypeOfObject = Object::
  _Array_slice_ = prototypeOfArray.slice
  _toString = call.bind(prototypeOfObject.toString)
  owns = call.bind(prototypeOfObject.hasOwnProperty)
  defineGetter = undefined
  defineSetter = undefined
  lookupGetter = undefined
  lookupSetter = undefined
  supportsAccessors = undefined
  if supportsAccessors = owns(prototypeOfObject, "__defineGetter__")
    defineGetter = call.bind(prototypeOfObject.__defineGetter__)
    defineSetter = call.bind(prototypeOfObject.__defineSetter__)
    lookupGetter = call.bind(prototypeOfObject.__lookupGetter__)
    lookupSetter = call.bind(prototypeOfObject.__lookupSetter__)
  unless [1, 2].splice(0).length is 2
    array_splice = Array::splice
    if ->
      makeArray = (l) ->
        a = []
        a.unshift l  while l--
        a
      array = []
      lengthBefore = undefined
      array.splice.bind(array, 0, 0).apply null, makeArray(20)
      array.splice.bind(array, 0, 0).apply null, makeArray(26)
      lengthBefore = array.length
      array.splice 5, 0, "XXX"
      true  if lengthBefore + 1 is array.length
    ()
      Array::splice = (start, deleteCount) ->
        unless arguments_.length
          []
        else
          array_splice.apply this, [(if start is undefined then 0 else start), (if deleteCount is undefined then (@length - start) else deleteCount)].concat(_Array_slice_.call(arguments_, 2))
    else
      Array::splice = (start, deleteCount) ->
        result = undefined
        args = _Array_slice_.call(arguments_, 2)
        addElementsCount = args.length
        return []  unless arguments_.length
        start = 0  if start is undefined
        deleteCount = @length - start  if deleteCount is undefined
        if addElementsCount > 0
          if deleteCount <= 0
            if start is @length
              @push.apply this, args
              return []
            if start is 0
              @unshift.apply this, args
              return []
          result = _Array_slice_.call(this, start, start + deleteCount)
          args.push.apply args, _Array_slice_.call(this, start + deleteCount, @length)
          args.unshift.apply args, _Array_slice_.call(this, 0, start)
          args.unshift 0, @length
          array_splice.apply this, args
          return result
        array_splice.call this, start, deleteCount
  unless [].unshift(0) is 1
    array_unshift = Array::unshift
    Array::unshift = ->
      array_unshift.apply this, arguments_
      @length
  unless Array.isArray
    Array.isArray = isArray = (obj) ->
      _toString(obj) is "[object Array]"
  boxedString = Object("a")
  splitString = boxedString[0] isnt "a" or (0 not of boxedString)
  unless Array::forEach
    Array::forEach = forEach = (fun) ->
      object = toObject(this)
      self = (if splitString and _toString(this) is "[object String]" then @split("") else object)
      thisp = arguments_[1]
      i = -1
      length = self.length >>> 0
      throw new TypeError()  unless _toString(fun) is "[object Function]"
      fun.call thisp, self[i], i, object  if i of self  while ++i < length
  unless Array::map
    Array::map = map = (fun) ->
      object = toObject(this)
      self = (if splitString and _toString(this) is "[object String]" then @split("") else object)
      length = self.length >>> 0
      result = Array(length)
      thisp = arguments_[1]
      throw new TypeError(fun + " is not a function")  unless _toString(fun) is "[object Function]"
      i = 0

      while i < length
        result[i] = fun.call(thisp, self[i], i, object)  if i of self
        i++
      result
  unless Array::filter
    Array::filter = filter = (fun) ->
      object = toObject(this)
      self = (if splitString and _toString(this) is "[object String]" then @split("") else object)
      length = self.length >>> 0
      result = []
      value = undefined
      thisp = arguments_[1]
      throw new TypeError(fun + " is not a function")  unless _toString(fun) is "[object Function]"
      i = 0

      while i < length
        if i of self
          value = self[i]
          result.push value  if fun.call(thisp, value, i, object)
        i++
      result
  unless Array::every
    Array::every = every = (fun) ->
      object = toObject(this)
      self = (if splitString and _toString(this) is "[object String]" then @split("") else object)
      length = self.length >>> 0
      thisp = arguments_[1]
      throw new TypeError(fun + " is not a function")  unless _toString(fun) is "[object Function]"
      i = 0

      while i < length
        return false  if i of self and not fun.call(thisp, self[i], i, object)
        i++
      true
  unless Array::some
    Array::some = some = (fun) ->
      object = toObject(this)
      self = (if splitString and _toString(this) is "[object String]" then @split("") else object)
      length = self.length >>> 0
      thisp = arguments_[1]
      throw new TypeError(fun + " is not a function")  unless _toString(fun) is "[object Function]"
      i = 0

      while i < length
        return true  if i of self and fun.call(thisp, self[i], i, object)
        i++
      false
  unless Array::reduce
    Array::reduce = reduce = (fun) ->
      object = toObject(this)
      self = (if splitString and _toString(this) is "[object String]" then @split("") else object)
      length = self.length >>> 0
      throw new TypeError(fun + " is not a function")  unless _toString(fun) is "[object Function]"
      throw new TypeError("reduce of empty array with no initial value")  if not length and arguments_.length is 1
      i = 0
      result = undefined
      if arguments_.length >= 2
        result = arguments_[1]
      else
        loop
          if i of self
            result = self[i++]
            break
          throw new TypeError("reduce of empty array with no initial value")  if ++i >= length
          break unless true
      while i < length
        result = fun.call(undefined, result, self[i], i, object)  if i of self
        i++
      result
  unless Array::reduceRight
    Array::reduceRight = reduceRight = (fun) ->
      object = toObject(this)
      self = (if splitString and _toString(this) is "[object String]" then @split("") else object)
      length = self.length >>> 0
      throw new TypeError(fun + " is not a function")  unless _toString(fun) is "[object Function]"
      throw new TypeError("reduceRight of empty array with no initial value")  if not length and arguments_.length is 1
      result = undefined
      i = length - 1
      if arguments_.length >= 2
        result = arguments_[1]
      else
        loop
          if i of self
            result = self[i--]
            break
          throw new TypeError("reduceRight of empty array with no initial value")  if --i < 0
          break unless true
      return result  if i < 0
      loop
        result = fun.call(undefined, result, self[i], i, object)  if i of this
        break unless i--
      result
  if not Array::indexOf or ([0, 1].indexOf(1, 2) isnt -1)
    Array::indexOf = indexOf = (sought) ->
      self = (if splitString and _toString(this) is "[object String]" then @split("") else toObject(this))
      length = self.length >>> 0
      return -1  unless length
      i = 0
      i = toInteger(arguments_[1])  if arguments_.length > 1
      i = (if i >= 0 then i else Math.max(0, length + i))
      while i < length
        return i  if i of self and self[i] is sought
        i++
      -1
  if not Array::lastIndexOf or ([0, 1].lastIndexOf(0, -3) isnt -1)
    Array::lastIndexOf = lastIndexOf = (sought) ->
      self = (if splitString and _toString(this) is "[object String]" then @split("") else toObject(this))
      length = self.length >>> 0
      return -1  unless length
      i = length - 1
      i = Math.min(i, toInteger(arguments_[1]))  if arguments_.length > 1
      i = (if i >= 0 then i else length - Math.abs(i))
      while i >= 0
        return i  if i of self and sought is self[i]
        i--
      -1
  unless Object.keys
    hasDontEnumBug = true
    dontEnums = ["toString", "toLocaleString", "valueOf", "hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable", "constructor"]
    dontEnumsLength = dontEnums.length
    for key of toString: null
      hasDontEnumBug = false
    Object.keys = keys = (object) ->
      throw new TypeError("Object.keys called on a non-object")  if (typeof object isnt "object" and typeof object isnt "function") or object is null
      keys = []
      for name of object
        keys.push name  if owns(object, name)
      if hasDontEnumBug
        i = 0
        ii = dontEnumsLength

        while i < ii
          dontEnum = dontEnums[i]
          keys.push dontEnum  if owns(object, dontEnum)
          i++
      keys
  negativeDate = -62198755200000
  negativeYearString = "-000001"
  if not Date::toISOString or (new Date(negativeDate).toISOString().indexOf(negativeYearString) is -1)
    Date::toISOString = toISOString = ->
      result = undefined
      length = undefined
      value = undefined
      year = undefined
      month = undefined
      throw new RangeError("Date.prototype.toISOString called on non-finite value.")  unless isFinite(this)
      year = @getUTCFullYear()
      month = @getUTCMonth()
      year += Math.floor(month / 12)
      month = (month % 12 + 12) % 12
      result = [month + 1, @getUTCDate(), @getUTCHours(), @getUTCMinutes(), @getUTCSeconds()]
      year = (((if year < 0 then "-" else ((if year > 9999 then "+" else "")))) + ("00000" + Math.abs(year)).slice((if 0 <= year and year <= 9999 then -4 else -6)))
      length = result.length
      while length--
        value = result[length]
        result[length] = "0" + value  if value < 10
      year + "-" + result.slice(0, 2).join("-") + "T" + result.slice(2).join(":") + "." + ("000" + @getUTCMilliseconds()).slice(-3) + "Z"
  dateToJSONIsSupported = false
  try
    dateToJSONIsSupported = (Date::toJSON and new Date(NaN).toJSON() is null and new Date(negativeDate).toJSON().indexOf(negativeYearString) isnt -1 and Date::toJSON.call(toISOString: ->
      true
    ))
  unless dateToJSONIsSupported
    Date::toJSON = toJSON = (key) ->
      o = Object(this)
      tv = toPrimitive(o)
      toISO = undefined
      return null  if typeof tv is "number" and not isFinite(tv)
      toISO = o.toISOString
      throw new TypeError("toISOString property is not callable")  unless typeof toISO is "function"
      toISO.call o
  if not Date.parse or "Date.parse is buggy"
    Date = ((NativeDate) ->
      Date = (Y, M, D, h, m, s, ms) ->
        length = arguments_.length
        if this instanceof NativeDate
          date = (if length is 1 and String(Y) is Y then new NativeDate(Date.parse(Y)) else (if length >= 7 then new NativeDate(Y, M, D, h, m, s, ms) else (if length >= 6 then new NativeDate(Y, M, D, h, m, s) else (if length >= 5 then new NativeDate(Y, M, D, h, m) else (if length >= 4 then new NativeDate(Y, M, D, h) else (if length >= 3 then new NativeDate(Y, M, D) else (if length >= 2 then new NativeDate(Y, M) else (if length >= 1 then new NativeDate(Y) else new NativeDate()))))))))
          date.constructor = Date
          return date
        NativeDate.apply this, arguments_
      dayFromMonth = (year, month) ->
        t = (if month > 1 then 1 else 0)
        months[month] + Math.floor((year - 1969 + t) / 4) - Math.floor((year - 1901 + t) / 100) + Math.floor((year - 1601 + t) / 400) + 365 * (year - 1970)
      toUTC = (t) ->
        Number new NativeDate(1970, 0, 1, 0, 0, 0, t)
      isoDateExpression = new RegExp("^" + "(\\d{4}|[+-]\\d{6})" + "(?:-(\\d{2})" + "(?:-(\\d{2})" + "(?:" + "T(\\d{2})" + ":(\\d{2})" + "(?:" + ":(\\d{2})" + "(?:(\\.\\d{1,}))?" + ")?" + "(" + "Z|" + "(?:" + "([-+])" + "(\\d{2})" + ":(\\d{2})" + ")" + ")?)?)?)?" + "$")
      months = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365]
      for key of NativeDate
        Date[key] = NativeDate[key]
      Date.now = NativeDate.now
      Date.UTC = NativeDate.UTC
      Date:: = NativeDate::
      Date::constructor = Date
      Date.parse = parse = (string) ->
        match = isoDateExpression.exec(string)
        if match
          year = Number(match[1])
          month = Number(match[2] or 1) - 1
          day = Number(match[3] or 1) - 1
          hour = Number(match[4] or 0)
          minute = Number(match[5] or 0)
          second = Number(match[6] or 0)
          millisecond = Math.floor(Number(match[7] or 0) * 1000)
          isLocalTime = Boolean(match[4] and not match[8])
          signOffset = (if match[9] is "-" then 1 else -1)
          hourOffset = Number(match[10] or 0)
          minuteOffset = Number(match[11] or 0)
          result = undefined
          if hour < ((if minute > 0 or second > 0 or millisecond > 0 then 24 else 25)) and minute < 60 and second < 60 and millisecond < 1000 and month > -1 and month < 12 and hourOffset < 24 and minuteOffset < 60 and day > -1 and day < (dayFromMonth(year, month + 1) - dayFromMonth(year, month))
            result = ((dayFromMonth(year, month) + day) * 24 + hour + hourOffset * signOffset) * 60
            result = ((result + minute + minuteOffset * signOffset) * 60 + second) * 1000 + millisecond
            result = toUTC(result)  if isLocalTime
            return result  if -8.64e15 <= result and result <= 8.64e15
          return NaN
        NativeDate.parse.apply this, arguments_

      Date
    )(Date)
  unless Date.now
    Date.now = now = ->
      new Date().getTime()
  if not Number::toFixed or (0.00008).toFixed(3) isnt "0.000" or (0.9).toFixed(0) is "0" or (1.255).toFixed(2) isnt "1.25" or (1000000000000000128).toFixed(0) isnt "1000000000000000128"
    (->
      multiply = (n, c) ->
        i = -1
        while ++i < size
          c += n * data[i]
          data[i] = c % base
          c = Math.floor(c / base)
      divide = (n) ->
        i = size
        c = 0
        while --i >= 0
          c += data[i]
          data[i] = Math.floor(c / n)
          c = (c % n) * base
      toString = ->
        i = size
        s = ""
        while --i >= 0
          if s isnt "" or i is 0 or data[i] isnt 0
            t = String(data[i])
            if s is ""
              s = t
            else
              s += "0000000".slice(0, 7 - t.length) + t
        s
      pow = (x, n, acc) ->
        (if n is 0 then acc else ((if n % 2 is 1 then pow(x, n - 1, acc * x) else pow(x * x, n / 2, acc))))
      log = (x) ->
        n = 0
        while x >= 4096
          n += 12
          x /= 4096
        while x >= 2
          n += 1
          x /= 2
        n
      base = undefined
      size = undefined
      data = undefined
      i = undefined
      base = 1e7
      size = 6
      data = [0, 0, 0, 0, 0, 0]
      Number::toFixed = (fractionDigits) ->
        f = undefined
        x = undefined
        s = undefined
        m = undefined
        e = undefined
        z = undefined
        j = undefined
        k = undefined
        f = Number(fractionDigits)
        f = (if f isnt f then 0 else Math.floor(f))
        throw new RangeError("Number.toFixed called with invalid number of decimals")  if f < 0 or f > 20
        x = Number(this)
        return "NaN"  if x isnt x
        return String(x)  if x <= -1e21 or x >= 1e21
        s = ""
        if x < 0
          s = "-"
          x = -x
        m = "0"
        if x > 1e-21
          e = log(x * pow(2, 69, 1)) - 69
          z = ((if e < 0 then x * pow(2, -e, 1) else x / pow(2, e, 1)))
          z *= 0x10000000000000
          e = 52 - e
          if e > 0
            multiply 0, z
            j = f
            while j >= 7
              multiply 1e7, 0
              j -= 7
            multiply pow(10, j, 1), 0
            j = e - 1
            while j >= 23
              divide 1 << 23
              j -= 23
            divide 1 << j
            multiply 1, 1
            divide 2
            m = toString()
          else
            multiply 0, z
            multiply 1 << (-e), 0
            m = toString() + "0.00000000000000000000".slice(2, 2 + f)
        if f > 0
          k = m.length
          if k <= f
            m = s + "0.0000000000000000000".slice(0, f - k + 2) + m
          else
            m = s + m.slice(0, k - f) + "." + m.slice(k - f)
        else
          m = s + m
        m
    )()
  string_split = String::split
  if "ab".split(/(?:ab)*/).length isnt 2 or ".".split(/(.?)(.?)/).length isnt 4 or "tesst".split(/(s)*/)[1] is "t" or "".split(/.?/).length or ".".split(/()()/).length > 1
    (->
      compliantExecNpcg = /()??/.exec("")[1] is undefined
      String::split = (separator, limit) ->
        string = this
        return []  if separator is undefined and limit is 0
        return string_split.apply(this, arguments_)  if Object::toString.call(separator) isnt "[object RegExp]"
        output = []
        flags = ((if separator.ignoreCase then "i" else "")) + ((if separator.multiline then "m" else "")) + ((if separator.extended then "x" else "")) + ((if separator.sticky then "y" else ""))
        lastLastIndex = 0
        separator = new RegExp(separator.source, flags + "g")
        separator2 = undefined
        match = undefined
        lastIndex = undefined
        lastLength = undefined
        string += ""
        separator2 = new RegExp("^" + separator.source + "$(?!\\s)", flags)  unless compliantExecNpcg
        limit = (if limit is undefined then -1 >>> 0 else limit >>> 0)
        while match = separator.exec(string)
          lastIndex = match.index + match[0].length
          if lastIndex > lastLastIndex
            output.push string.slice(lastLastIndex, match.index)
            if not compliantExecNpcg and match.length > 1
              match[0].replace separator2, ->
                i = 1

                while i < arguments_.length - 2
                  match[i] = undefined  if arguments_[i] is undefined
                  i++

            Array::push.apply output, match.slice(1)  if match.length > 1 and match.index < string.length
            lastLength = match[0].length
            lastLastIndex = lastIndex
            break  if output.length >= limit
          separator.lastIndex++  if separator.lastIndex is match.index
        if lastLastIndex is string.length
          output.push ""  if lastLength or not separator.test("")
        else
          output.push string.slice(lastLastIndex)
        (if output.length > limit then output.slice(0, limit) else output)
    )()
  else if "0".split(undefined, 0).length
    String::split = (separator, limit) ->
      return []  if separator is undefined and limit is 0
      string_split.apply this, arguments_
  if "".substr and "0b".substr(-1) isnt "b"
    string_substr = String::substr
    String::substr = (start, length) ->
      string_substr.call this, (if start < 0 then ((if (start = @length + start) < 0 then 0 else start)) else start), length
  ws = "\t\n\u000b\f\r   ᠎    " + "         　 " + " ﻿"
  if not String::trim or ws.trim()
    ws = "[" + ws + "]"
    trimBeginRegexp = new RegExp("^" + ws + ws + "*")
    trimEndRegexp = new RegExp(ws + ws + "*$")
    String::trim = trim = ->
      throw new TypeError("can't convert " + this + " to object")  if this is undefined or this is null
      String(this).replace(trimBeginRegexp, "").replace trimEndRegexp, ""
  
  # ES5 9.9
  # http://es5.github.com/#x9.9
  toObject = (o) ->
    # this matches both null and undefined
    throw new TypeError("can't convert " + o + " to object")  unless o?
    Object o

