# Copyright 2009-2012 by contributors, MIT License
# vim: ts=4 sts=4 sw=4 expandtab

# Module systems magic dance
((definition) ->
  
  # RequireJS
  if typeof define is "function"
    define definition
  
  # YUI3
  else if typeof YUI is "function"
    YUI.add "es5-sham", definition
  
  # CommonJS and <script>
  else
    definition()
) ->
  
  # If JS engine supports accessors creating shortcuts.
  
  # ES5 15.2.3.2
  # http://es5.github.com/#x15.2.3.2
  
  # https://github.com/kriskowal/es5-shim/issues#issue/2
  # http://ejohn.org/blog/objectgetprototypeof/
  # recommended by fschaefer on github
  
  #ES5 15.2.3.3
  #http://es5.github.com/#x15.2.3.3
  doesGetOwnPropertyDescriptorWork = (object) ->
    try
      object.sentinel = 0
      return Object.getOwnPropertyDescriptor(object, "sentinel").value is 0
  
  # returns falsy
  
  #check whether getOwnPropertyDescriptor works if it's given. Otherwise,
  #shim partially.
  
  # make a valiant attempt to use the real getOwnPropertyDescriptor
  # for I8's DOM elements.
  
  # try the shim if the real one doesn't work
  
  # If object does not owns property return undefined immediately.
  
  # If object has a property then it's for sure both `enumerable` and
  # `configurable`.
  
  # If JS engine supports accessor properties then property may be a
  # getter or setter.
  
  # Unfortunately `__lookupGetter__` will return a getter even
  # if object has own non getter property along with a same named
  # inherited getter. To avoid misbehavior we temporary remove
  # `__proto__` so that `__lookupGetter__` will return getter only
  # if it's owned by an object.
  
  # Once we have getter and setter we can put values back.
  
  # If it was accessor property we're done and return here
  # in order to avoid adding `value` to the descriptor.
  
  # If we got this far we know that object has an own property that is
  # not an accessor so we set it as a value and return descriptor.
  
  # ES5 15.2.3.4
  # http://es5.github.com/#x15.2.3.4
  
  # ES5 15.2.3.5
  # http://es5.github.com/#x15.2.3.5
  
  # Contributed by Brandon Benvie, October, 2012
  
  # In old IE __proto__ can't be used to manually set `null`, nor does
  # any other method exist to make an object that inherits from nothing,
  # aside from Object.prototype itself. Instead, create a new global
  # object and *steal* its Object.prototype and strip it bare. This is
  # used as the prototype to create nullary objects.
  
  # short-circuit future calls
  # An empty constructor.
  
  # In the native implementation `parent` can be `null`
  # OR *any* `instanceof Object`  (Object|Function|Array|RegExp|etc)
  # Use `typeof` tho, b/c in old IE, DOM elements are not `instanceof Object`
  # like they are in modern browsers. Using `Object.create` on DOM elements
  # is...err...probably inappropriate, but the native version allows for it.
  # same msg as Chrome
  
  # IE has no built-in implementation of `Object.getPrototypeOf`
  # neither `__proto__`, but this manually setting `__proto__` will
  # guarantee that `Object.getPrototypeOf` will work as expected with
  # objects created using `Object.create`
  
  # ES5 15.2.3.6
  # http://es5.github.com/#x15.2.3.6
  
  # Patch for WebKit and IE8 standard mode
  # Designed by hax <hax.github.com>
  # related issue: https://github.com/kriskowal/es5-shim/issues#issue/5
  # IE8 Reference:
  #     http://msdn.microsoft.com/en-us/library/dd282900.aspx
  #     http://msdn.microsoft.com/en-us/library/dd229916.aspx
  # WebKit Bugs:
  #     https://bugs.webkit.org/show_bug.cgi?id=36423
  doesDefinePropertyWork = (object) ->
    try
      Object.defineProperty object, "sentinel", {}
      return "sentinel" of object
  call = Function::call
  prototypeOfObject = Object::
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
  unless Object.getPrototypeOf
    Object.getPrototypeOf = getPrototypeOf = (object) ->
      object.__proto__ or ((if object.constructor then object.constructor:: else prototypeOfObject))
  if Object.defineProperty
    getOwnPropertyDescriptorWorksOnObject = doesGetOwnPropertyDescriptorWork({})
    getOwnPropertyDescriptorWorksOnDom = typeof document is "undefined" or doesGetOwnPropertyDescriptorWork(document.createElement("div"))
    getOwnPropertyDescriptorFallback = Object.getOwnPropertyDescriptor  if not getOwnPropertyDescriptorWorksOnDom or not getOwnPropertyDescriptorWorksOnObject
  if not Object.getOwnPropertyDescriptor or getOwnPropertyDescriptorFallback
    ERR_NON_OBJECT = "Object.getOwnPropertyDescriptor called on a non-object: "
    Object.getOwnPropertyDescriptor = getOwnPropertyDescriptor = (object, property) ->
      throw new TypeError(ERR_NON_OBJECT + object)  if (typeof object isnt "object" and typeof object isnt "function") or object is null
      if getOwnPropertyDescriptorFallback
        try
          return getOwnPropertyDescriptorFallback.call(Object, object, property)
      return  unless owns(object, property)
      descriptor =
        enumerable: true
        configurable: true

      if supportsAccessors
        prototype = object.__proto__
        object.__proto__ = prototypeOfObject
        getter = lookupGetter(object, property)
        setter = lookupSetter(object, property)
        object.__proto__ = prototype
        if getter or setter
          descriptor.get = getter  if getter
          descriptor.set = setter  if setter
          return descriptor
      descriptor.value = object[property]
      descriptor.writable = true
      descriptor
  unless Object.getOwnPropertyNames
    Object.getOwnPropertyNames = getOwnPropertyNames = (object) ->
      Object.keys object
  unless Object.create
    createEmpty = undefined
    supportsProto = Object::__proto__ is null
    if supportsProto or typeof document is "undefined"
      createEmpty = ->
        __proto__: null
    else
      createEmpty = ->
        Empty = ->
        iframe = document.createElement("iframe")
        parent = document.body or document.documentElement
        iframe.style.display = "none"
        parent.appendChild iframe
        iframe.src = "javascript:"
        empty = iframe.contentWindow.Object::
        parent.removeChild iframe
        iframe = null
        delete empty.constructor

        delete empty.hasOwnProperty

        delete empty.propertyIsEnumerable

        delete empty.isPrototypeOf

        delete empty.toLocaleString

        delete empty.toString

        delete empty.valueOf

        empty.__proto__ = null
        Empty:: = empty
        createEmpty = ->
          new Empty()

        new Empty()
    Object.create = create = (prototype, properties) ->
      Type = ->
      object = undefined
      if prototype is null
        object = createEmpty()
      else
        throw new TypeError("Object prototype may only be an Object or null")  if typeof prototype isnt "object" and typeof prototype isnt "function"
        Type:: = prototype
        object = new Type()
        object.__proto__ = prototype
      Object.defineProperties object, properties  if properties isnt undefined
      object
  
  # returns falsy
  
  # check whether defineProperty works if it's given. Otherwise,
  # shim partially.
  if Object.defineProperty
    definePropertyWorksOnObject = doesDefinePropertyWork({})
    definePropertyWorksOnDom = typeof document is "undefined" or doesDefinePropertyWork(document.createElement("div"))
    if not definePropertyWorksOnObject or not definePropertyWorksOnDom
      definePropertyFallback = Object.defineProperty
      definePropertiesFallback = Object.defineProperties
  if not Object.defineProperty or definePropertyFallback
    ERR_NON_OBJECT_DESCRIPTOR = "Property description must be an object: "
    ERR_NON_OBJECT_TARGET = "Object.defineProperty called on non-object: "
    ERR_ACCESSORS_NOT_SUPPORTED = "getters & setters can not be defined " + "on this javascript engine"
    Object.defineProperty = defineProperty = (object, property, descriptor) ->
      throw new TypeError(ERR_NON_OBJECT_TARGET + object)  if (typeof object isnt "object" and typeof object isnt "function") or object is null
      throw new TypeError(ERR_NON_OBJECT_DESCRIPTOR + descriptor)  if (typeof descriptor isnt "object" and typeof descriptor isnt "function") or descriptor is null
      
      # make a valiant attempt to use the real defineProperty
      # for I8's DOM elements.
      if definePropertyFallback
        try
          return definePropertyFallback.call(Object, object, property, descriptor)
      
      # try the shim if the real one doesn't work
      
      # If it's a data property.
      if owns(descriptor, "value")
        
        # fail silently if "writable", "enumerable", or "configurable"
        # are requested but not supported
        #
        #            // alternate approach:
        #            if ( // can't implement these features; allow false but not true
        #                !(owns(descriptor, "writable") ? descriptor.writable : true) ||
        #                !(owns(descriptor, "enumerable") ? descriptor.enumerable : true) ||
        #                !(owns(descriptor, "configurable") ? descriptor.configurable : true)
        #            )
        #                throw new RangeError(
        #                    "This implementation of Object.defineProperty does not " +
        #                    "support configurable, enumerable, or writable."
        #                );
        #            
        if supportsAccessors and (lookupGetter(object, property) or lookupSetter(object, property))
          
          # As accessors are supported only on engines implementing
          # `__proto__` we can safely override `__proto__` while defining
          # a property to make sure that we don't hit an inherited
          # accessor.
          prototype = object.__proto__
          object.__proto__ = prototypeOfObject
          
          # Deleting a property anyway since getter / setter may be
          # defined on object itself.
          delete object[property]

          object[property] = descriptor.value
          
          # Setting original `__proto__` back now.
          object.__proto__ = prototype
        else
          object[property] = descriptor.value
      else
        throw new TypeError(ERR_ACCESSORS_NOT_SUPPORTED)  unless supportsAccessors
        
        # If we got that far then getters and setters can be defined !!
        defineGetter object, property, descriptor.get  if owns(descriptor, "get")
        defineSetter object, property, descriptor.set  if owns(descriptor, "set")
      object
  
  # ES5 15.2.3.7
  # http://es5.github.com/#x15.2.3.7
  if not Object.defineProperties or definePropertiesFallback
    Object.defineProperties = defineProperties = (object, properties) ->
      
      # make a valiant attempt to use the real defineProperties
      if definePropertiesFallback
        try
          return definePropertiesFallback.call(Object, object, properties)
      
      # try the shim if the real one doesn't work
      for property of properties
        Object.defineProperty object, property, properties[property]  if owns(properties, property) and property isnt "__proto__"
      object
  
  # ES5 15.2.3.8
  # http://es5.github.com/#x15.2.3.8
  unless Object.seal
    Object.seal = seal = (object) ->
      
      # this is misleading and breaks feature-detection, but
      # allows "securable" code to "gracefully" degrade to working
      # but insecure code.
      object
  
  # ES5 15.2.3.9
  # http://es5.github.com/#x15.2.3.9
  unless Object.freeze
    Object.freeze = freeze = (object) ->
      
      # this is misleading and breaks feature-detection, but
      # allows "securable" code to "gracefully" degrade to working
      # but insecure code.
      object
  
  # detect a Rhino bug and patch it
  try
    Object.freeze ->

  catch exception
    Object.freeze = (freeze = (freezeObject) ->
      freeze = (object) ->
        if typeof object is "function"
          object
        else
          freezeObject object
    )(Object.freeze)
  
  # ES5 15.2.3.10
  # http://es5.github.com/#x15.2.3.10
  unless Object.preventExtensions
    Object.preventExtensions = preventExtensions = (object) ->
      
      # this is misleading and breaks feature-detection, but
      # allows "securable" code to "gracefully" degrade to working
      # but insecure code.
      object
  
  # ES5 15.2.3.11
  # http://es5.github.com/#x15.2.3.11
  unless Object.isSealed
    Object.isSealed = isSealed = (object) ->
      false
  
  # ES5 15.2.3.12
  # http://es5.github.com/#x15.2.3.12
  unless Object.isFrozen
    Object.isFrozen = isFrozen = (object) ->
      false
  
  # ES5 15.2.3.13
  # http://es5.github.com/#x15.2.3.13
  unless Object.isExtensible
    Object.isExtensible = isExtensible = (object) ->
      
      # 1. If Type(O) is not Object throw a TypeError exception.
      throw new TypeError()  if Object(object) isnt object # TODO message
      
      # 2. Return the Boolean value of the [[Extensible]] internal property of O.
      name = ""
      name += "?"  while owns(object, name)
      object[name] = true
      returnValue = owns(object, name)
      delete object[name]

      returnValue

