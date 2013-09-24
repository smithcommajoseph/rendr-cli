#! jQuery v1.9.1 | (c) 2005, 2012 jQuery Foundation, Inc. | jquery.org/license
#
((e, t) ->
  M = (e) ->
    t = e.length
    n = b.type(e)
    (if b.isWindow(e) then not 1 else (if 1 is e.nodeType and t then not 0 else "array" is n or "function" isnt n and (0 is t or "number" is typeof t and t > 0 and t - 1 of e)))
  F = (e) ->
    t = _[e] = {}
    b.each(e.match(w) or [], (e, n) ->
      t[n] = not 0
    )
    t
  P = (e, n, r, i) ->
    if b.acceptData(e)
      o = undefined
      a = undefined
      s = b.expando
      u = "string" is typeof n
      l = e.nodeType
      p = (if l then b.cache else e)
      f = (if l then e[s] else e[s] and s)
      if f and p[f] and (i or p[f].data) or not u or r isnt t
        f or ((if l then e[s] = f = c.pop() or b.guid++ else f = s))
        p[f] or (p[f] = {}
        l or (p[f].toJSON = b.noop)
        )
        ("object" is typeof n or "function" is typeof n) and ((if i then p[f] = b.extend(p[f], n) else p[f].data = b.extend(p[f].data, n)))
        o = p[f]
        i or (o.data or (o.data = {})
        o = o.data
        )
        r isnt t and (o[b.camelCase(n)] = r)
        (if u then (a = o[n]
        null is a and (a = o[b.camelCase(n)])
        ) else a = o)
        a
  R = (e, t, n) ->
    if b.acceptData(e)
      r = undefined
      i = undefined
      o = undefined
      a = e.nodeType
      s = (if a then b.cache else e)
      u = (if a then e[b.expando] else b.expando)
      if s[u]
        if t and (o = (if n then s[u] else s[u].data))
          (if b.isArray(t) then t = t.concat(b.map(t, b.camelCase)) else (if t of o then t = [t] else (t = b.camelCase(t)
          t = (if t of o then [t] else t.split(" "))
          )))
          r = 0
          i = t.length

          while i > r
            delete o[t[r]]
            r++
          return  unless ((if n then $ else b.isEmptyObject))(o)
        (n or (delete s[u].data

        $(s[u])
        )) and ((if a then b.cleanData([e], not 0) else (if b.support.deleteExpando or s isnt s.window then delete s[u]
         else s[u] = null)))
  W = (e, n, r) ->
    if r is t and 1 is e.nodeType
      i = "data-" + n.replace(B, "-$1").toLowerCase()
      if r = e.getAttribute(i)
      "string" is typeof r
        try
          r = (if "true" is r then not 0 else (if "false" is r then not 1 else (if "null" is r then null else (if +r + "" is r then +r else (if O.test(r) then b.parseJSON(r) else r)))))
        b.data e, n, r
      else
        r = t
    r
  $ = (e) ->
    t = undefined
    for t of e
      return not 1  if ("data" isnt t or not b.isEmptyObject(e[t])) and "toJSON" isnt t
    not 0
  it = ->
    not 0
  ot = ->
    not 1
  pt = (e, t) ->
    loop
      e = e[t]
      break unless e and 1 isnt e.nodeType
    e
  ft = (e, t, n) ->
    if t = t or 0
    b.isFunction(t)
      return b.grep(e, (e, r) ->
        i = !!t.call(e, r, e)
        i is n
      )
    if t.nodeType
      return b.grep(e, (e) ->
        e is t is n
      )
    if "string" is typeof t
      r = b.grep(e, (e) ->
        1 is e.nodeType
      )
      return b.filter(t, r, not n)  if ut.test(t)
      t = b.filter(t, r)
    b.grep e, (e) ->
      b.inArray(e, t) >= 0 is n

  dt = (e) ->
    t = ht.split("|")
    n = e.createDocumentFragment()
    n.createElement t.pop()  while t.length  if n.createElement
    n
  Lt = (e, t) ->
    e.getElementsByTagName(t)[0] or e.appendChild(e.ownerDocument.createElement(t))
  Ht = (e) ->
    t = e.getAttributeNode("type")
    e.type = (t and t.specified) + "/" + e.type
    e
  qt = (e) ->
    t = Et.exec(e.type)
    (if t then e.type = t[1] else e.removeAttribute("type"))
    e
  Mt = (e, t) ->
    n = undefined
    r = 0
    while null isnt (n = e[r])
      b._data n, "globalEval", not t or b._data(t[r], "globalEval")
      r++
  _t = (e, t) ->
    if 1 is t.nodeType and b.hasData(e)
      n = undefined
      r = undefined
      i = undefined
      o = b._data(e)
      a = b._data(t, o)
      s = o.events
      if s
        delete a.handle

        a.events = {}

        for n of s
          r = 0
          i = s[n].length

          while i > r
            b.event.add t, n, s[n][r]
            r++
      a.data and (a.data = b.extend({}, a.data))
  Ft = (e, t) ->
    n = undefined
    r = undefined
    i = undefined
    if 1 is t.nodeType
      if n = t.nodeName.toLowerCase()
      not b.support.noCloneEvent and t[b.expando]
        i = b._data(t)
        for r of i.events
          b.removeEvent t, r, i.handle
        t.removeAttribute b.expando
      (if "script" is n and t.text isnt e.text then (Ht(t).text = e.text
      qt(t)
      ) else (if "object" is n then (t.parentNode and (t.outerHTML = e.outerHTML)
      b.support.html5Clone and e.innerHTML and not b.trim(t.innerHTML) and (t.innerHTML = e.innerHTML)
      ) else (if "input" is n and Nt.test(e.type) then (t.defaultChecked = t.checked = e.checked
      t.value isnt e.value and (t.value = e.value)
      ) else (if "option" is n then t.defaultSelected = t.selected = e.defaultSelected else ("input" is n or "textarea" is n) and (t.defaultValue = e.defaultValue)))))
  Ot = (e, n) ->
    r = undefined
    o = undefined
    a = 0
    s = (if typeof e.getElementsByTagName isnt i then e.getElementsByTagName(n or "*") else (if typeof e.querySelectorAll isnt i then e.querySelectorAll(n or "*") else t))
    unless s
      s = []
      r = e.childNodes or e

      while null isnt (o = r[a])
        (if not n or b.nodeName(o, n) then s.push(o) else b.merge(s, Ot(o, n)))
        a++
    (if n is t or n and b.nodeName(e, n) then b.merge([e], s) else s)
  Bt = (e) ->
    Nt.test(e.type) and (e.defaultChecked = e.checked)
  tn = (e, t) ->
    return t  if t of e
    n = t.charAt(0).toUpperCase() + t.slice(1)
    r = t
    i = en.length
    while i--
      return t  if t = en[i] + n
      t of e
    r
  nn = (e, t) ->
    e = t or e
    "none" is b.css(e, "display") or not b.contains(e.ownerDocument, e)
  rn = (e, t) ->
    n = undefined
    r = undefined
    i = undefined
    o = []
    a = 0
    s = e.length
    while s > a
      r = e[a]
      r.style and (o[a] = b._data(r, "olddisplay")
      n = r.style.display
      (if t then (o[a] or "none" isnt n or (r.style.display = "")
      "" is r.style.display and nn(r) and (o[a] = b._data(r, "olddisplay", un(r.nodeName)))
      ) else o[a] or (i = nn(r)
      (n and "none" isnt n or not i) and b._data(r, "olddisplay", (if i then n else b.css(r, "display")))
      ))
      )
      a++
    a = 0
    while s > a
      r = e[a]
      r.style and (t and "none" isnt r.style.display and "" isnt r.style.display or (r.style.display = (if t then o[a] or "" else "none")))
      a++
    e
  on = (e, t, n) ->
    r = Vt.exec(t)
    (if r then Math.max(0, r[1] - (n or 0)) + (r[2] or "px") else t)
  an = (e, t, n, r, i) ->
    o = (if n is ((if r then "border" else "content")) then 4 else (if "width" is t then 1 else 0))
    a = 0
    while 4 > o
      "margin" is n and (a += b.css(e, n + Zt[o], not 0, i))
      (if r then ("content" is n and (a -= b.css(e, "padding" + Zt[o], not 0, i))
      "margin" isnt n and (a -= b.css(e, "border" + Zt[o] + "Width", not 0, i))
      ) else (a += b.css(e, "padding" + Zt[o], not 0, i)
      "padding" isnt n and (a += b.css(e, "border" + Zt[o] + "Width", not 0, i))
      ))
      o += 2
    a
  sn = (e, t, n) ->
    r = not 0
    i = (if "width" is t then e.offsetWidth else e.offsetHeight)
    o = Rt(e)
    a = b.support.boxSizing and "border-box" is b.css(e, "boxSizing", not 1, o)
    if 0 >= i or null is i
      return i  if i = Wt(e, t, o)
      (0 > i or null is i) and (i = e.style[t])
      Yt.test(i)

      r = a and (b.support.boxSizingReliable or i is e.style[t])
      i = parseFloat(i) or 0
    i + an(e, t, n or ((if a then "border" else "content")), r, o) + "px"
  un = (e) ->
    t = o
    n = Gt[e]
    n or (n = ln(e, t)
    "none" isnt n and n or (Pt = (Pt or b("<iframe frameborder='0' width='0' height='0'/>").css("cssText", "display:block !important")).appendTo(t.documentElement)
    t = (Pt[0].contentWindow or Pt[0].contentDocument).document
    t.write("<!doctype html><html><body>")
    t.close()
    n = ln(e, t)
    Pt.detach()
    )
    Gt[e] = n
    )
    n
  ln = (e, t) ->
    n = b(t.createElement(e)).appendTo(t.body)
    r = b.css(n[0], "display")
    n.remove()
    r
  gn = (e, t, n, r) ->
    i = undefined
    if b.isArray(t)
      b.each t, (t, i) ->
        (if n or pn.test(e) then r(e, i) else gn(e + "[" + ((if "object" is typeof i then t else "")) + "]", i, n, r))

    else if n or "object" isnt b.type(t)
      r e, t
    else
      for i of t
        gn e + "[" + i + "]", t[i], n, r
  Hn = (e) ->
    (t, n) ->
      "string" isnt typeof t and (n = t
      t = "*"
      )
      r = undefined
      i = 0
      o = t.toLowerCase().match(w) or []
      if b.isFunction(n)
        while r = o[i++]
          (if "+" is r[0] then (r = r.slice(1) or "*"
          (e[r] = e[r] or []).unshift(n)
          ) else (e[r] = e[r] or []).push(n))
  qn = (e, n, r, i) ->
    s = (u) ->
      l = undefined
      o[u] = not 0
      b.each(e[u] or [], (e, u) ->
        c = u(n, r, i)
        (if "string" isnt typeof c or a or o[c] then (if a then not (l = c) else t) else (n.dataTypes.unshift(c)
        s(c)
        not 1
        ))
      )
      l
    o = {}
    a = e is jn
    s(n.dataTypes[0]) or not o["*"] and s("*")
  Mn = (e, n) ->
    r = undefined
    i = undefined
    o = b.ajaxSettings.flatOptions or {}
    for i of n
      n[i] isnt t and (((if o[i] then e else r or (r = {})))[i] = n[i])
    r and b.extend(not 0, e, r)
    e
  _n = (e, n, r) ->
    i = undefined
    o = undefined
    a = undefined
    s = undefined
    u = e.contents
    l = e.dataTypes
    c = e.responseFields
    for s of c
      s of r and (n[c[s]] = r[s])
    while "*" is l[0]
      l.shift()
      o is t and (o = e.mimeType or n.getResponseHeader("Content-Type"))
    if o
      for s of u
        if u[s] and u[s].test(o)
          l.unshift s
          break
    unless l[0] of r
      for s of r
        if not l[0] or e.converters[s + " " + l[0]]
          a = s
          break
        i or (i = s)
      a = a or i
    (if a then (a isnt l[0] and l.unshift(a)
    r[a]
    ) else t)
  Fn = (e, t) ->
    n = undefined
    r = undefined
    i = undefined
    o = undefined
    a = {}
    s = 0
    u = e.dataTypes.slice()
    l = u[0]
    if e.dataFilter and (t = e.dataFilter(t, e.dataType))
    u[1]
      for i of e.converters
        a[i.toLowerCase()] = e.converters[i]
    while r = u[++s]
      if "*" isnt r
        if "*" isnt l and l isnt r
          if i = a[l + " " + r] or a["* " + r]
          not i
            for n of a
              if o = n.split(" ")
              o[1] is r and (i = a[l + " " + o[0]] or a["* " + o[0]])
                (if i is not 0 then i = a[n] else a[n] isnt not 0 and (r = o[0]
                u.splice(s--, 0, r)
                ))
                break
          if i isnt not 0
            if i and e["throws"]
              t = i(t)
            else
              try
                t = i(t)
              catch c
                return (
                  state: "parsererror"
                  error: (if i then c else "No conversion from " + l + " to " + r)
                )
        l = r
    state: "success"
    data: t
  In = ->
    try
      return new e.XMLHttpRequest
  zn = ->
    try
      return new e.ActiveXObject("Microsoft.XMLHTTP")
  Kn = ->
    setTimeout(->
      Xn = t
    )
    Xn = b.now()
  Zn = (e, t) ->
    b.each t, (t, n) ->
      r = (Qn[t] or []).concat(Qn["*"])
      i = 0
      o = r.length
      while o > i
        return  if r[i].call(e, t, n)
        i++

  er = (e, t, n) ->
    r = undefined
    i = undefined
    o = 0
    a = Gn.length
    s = b.Deferred().always(->
      delete u.elem
    )
    u = ->
      return not 1  if i
      t = Xn or Kn()
      n = Math.max(0, l.startTime + l.duration - t)
      r = n / l.duration or 0
      o = 1 - r
      a = 0
      u = l.tweens.length
      while u > a
        l.tweens[a].run o
        a++
      s.notifyWith(e, [l, o, n])
      (if 1 > o and u then n else (s.resolveWith(e, [l])
      not 1
      ))

    l = s.promise(
      elem: e
      props: b.extend({}, t)
      opts: b.extend(not 0,
        specialEasing: {}
      , n)
      originalProperties: t
      originalOptions: n
      startTime: Xn or Kn()
      duration: n.duration
      tweens: []
      createTween: (t, n) ->
        r = b.Tween(e, l.opts, t, n, l.opts.specialEasing[t] or l.opts.easing)
        l.tweens.push(r)
        r

      stop: (t) ->
        n = 0
        r = (if t then l.tweens.length else 0)
        return this  if i
        i = not 0
        while r > n
          l.tweens[n].run 1
          n++
        (if t then s.resolveWith(e, [l, t]) else s.rejectWith(e, [l, t]))
        this
    )
    c = l.props
    tr(c, l.opts.specialEasing)
    while a > o
      return r  if r = Gn[o].call(l, e, c, l.opts)
      o++
    Zn(l, c)
    b.isFunction(l.opts.start) and l.opts.start.call(e, l)
    b.fx.timer(b.extend(u,
      elem: e
      anim: l
      queue: l.opts.queue
    ))
    l.progress(l.opts.progress).done(l.opts.done, l.opts.complete).fail(l.opts.fail).always(l.opts.always)
  tr = (e, t) ->
    n = undefined
    r = undefined
    i = undefined
    o = undefined
    a = undefined
    for i of e
      if r = b.camelCase(i)
      o = t[r]
      n = e[i]
      b.isArray(n) and (o = n[1]
      n = e[i] = n[0]
      )
      i isnt r and (e[r] = n
      delete e[i]

      )
      a = b.cssHooks[r]
      a and "expand" of a
        n = a.expand(n)
        delete e[r]


        for i of n
          i of e or (e[i] = n[i]
          t[i] = o
          )
      else
        t[r] = o
  nr = (e, t, n) ->
    r = undefined
    i = undefined
    o = undefined
    a = undefined
    s = undefined
    u = undefined
    l = undefined
    c = undefined
    p = undefined
    f = this
    d = e.style
    h = {}
    g = []
    m = e.nodeType and nn(e)
    n.queue or (c = b._queueHooks(e, "fx")
    null is c.unqueued and (c.unqueued = 0
    p = c.empty.fire
    c.empty.fire = ->
      c.unqueued or p()

    )
    c.unqueued++
    f.always(->
      f.always ->
        c.unqueued--
        b.queue(e, "fx").length or c.empty.fire()

    )
    )
    1 is e.nodeType and ("height" of t or "width" of t) and (n.overflow = [d.overflow, d.overflowX, d.overflowY]
    "inline" is b.css(e, "display") and "none" is b.css(e, "float") and ((if b.support.inlineBlockNeedsLayout and "inline" isnt un(e.nodeName) then d.zoom = 1 else d.display = "inline-block"))
    )
    n.overflow and (d.overflow = "hidden"
    b.support.shrinkWrapBlocks or f.always(->
      d.overflow = n.overflow[0]
      d.overflowX = n.overflow[1]
      d.overflowY = n.overflow[2]
    )
    )

    for i of t
      if a = t[i]
      Vn.exec(a)
        continue  if delete t[i]

        u = u or "toggle" is a
        a is ((if m then "hide" else "show"))

        g.push i
    if o = g.length
      s = b._data(e, "fxshow") or b._data(e, "fxshow", {})
      "hidden" of s and (m = s.hidden)
      u and (s.hidden = not m)
      (if m then b(e).show() else f.done(->
        b(e).hide()
      ))
      f.done(->
        t = undefined
        b._removeData e, "fxshow"
        for t of h
          b.style e, t, h[t]
      )

      i = 0
      while o > i
        r = g[i]
        l = f.createTween(r, (if m then s[r] else 0))
        h[r] = s[r] or b.style(e, r)
        r of s or (s[r] = l.start
        m and (l.end = l.start
        l.start = (if "width" is r or "height" is r then 1 else 0)
        )
        )
        i++
  rr = (e, t, n, r, i) ->
    new rr::init(e, t, n, r, i)
  ir = (e, t) ->
    n = undefined
    r = height: e
    i = 0
    t = (if t then 1 else 0)
    while 4 > i
      n = Zt[i]
      r["margin" + n] = r["padding" + n] = e
      i += 2 - t
    t and (r.opacity = r.width = e)
    r
  or = (e) ->
    (if b.isWindow(e) then e else (if 9 is e.nodeType then e.defaultView or e.parentWindow else not 1))
  n = undefined
  r = undefined
  i = typeof t
  o = e.document
  a = e.location
  s = e.jQuery
  u = e.$
  l = {}
  c = []
  p = "1.9.1"
  f = c.concat
  d = c.push
  h = c.slice
  g = c.indexOf
  m = l.toString
  y = l.hasOwnProperty
  v = p.trim
  b = (e, t) ->
    new b.fn.init(e, t, r)

  x = /[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/.source
  w = /\S+/g
  T = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g
  N = /^(?:(<[\w\W]+>)[^>]*|#([\w-]*))$/
  C = /^<(\w+)\s*\/?>(?:<\/\1>|)$/
  k = /^[\],:{}\s]*$/
  E = /(?:^|:|,)(?:\s*\[)+/g
  S = /\\(?:["\\\/bfnrt]|u[\da-fA-F]{4})/g
  A = /"[^"\\\r\n]*"|true|false|null|-?(?:\d+\.|)\d+(?:[eE][+-]?\d+|)/g
  j = /^-ms-/
  D = /-([\da-z])/g
  L = (e, t) ->
    t.toUpperCase()

  H = (e) ->
    (o.addEventListener or "load" is e.type or "complete" is o.readyState) and (q()
    b.ready()
    )

  q = ->
    (if o.addEventListener then (o.removeEventListener("DOMContentLoaded", H, not 1)
    e.removeEventListener("load", H, not 1)
    ) else (o.detachEvent("onreadystatechange", H)
    e.detachEvent("onload", H)
    ))

  b.fn = b:: =
    jquery: p
    constructor: b
    init: (e, n, r) ->
      i = undefined
      a = undefined
      return this  unless e
      if "string" is typeof e
        return (if not n or n.jquery then (n or r).find(e) else @constructor(n).find(e))  if i = (if "<" is e.charAt(0) and ">" is e.charAt(e.length - 1) and e.length >= 3 then [null, e, null] else N.exec(e))
        not i or not i[1] and n

        if i[1]
          if n = (if n instanceof b then n[0] else n)
          b.merge(this, b.parseHTML(i[1], (if n and n.nodeType then n.ownerDocument or n else o), not 0))
          C.test(i[1]) and b.isPlainObject(n)
            for i of n
              (if b.isFunction(this[i]) then this[i](n[i]) else @attr(i, n[i]))
          return this
        if a = o.getElementById(i[2])
        a and a.parentNode
          return r.find(e)  if a.id isnt i[2]
          @length = 1
          this[0] = a
        return @context = o
        @selector = e
        this
      (if e.nodeType then (@context = this[0] = e
      @length = 1
      this
      ) else (if b.isFunction(e) then r.ready(e) else (e.selector isnt t and (@selector = e.selector
      @context = e.context
      )
      b.makeArray(e, this)
      )))

    selector: ""
    length: 0
    size: ->
      @length

    toArray: ->
      h.call this

    get: (e) ->
      (if null is e then @toArray() else (if 0 > e then this[@length + e] else this[e]))

    pushStack: (e) ->
      t = b.merge(@constructor(), e)
      t.prevObject = this
      t.context = @context
      t

    each: (e, t) ->
      b.each this, e, t

    ready: (e) ->
      b.ready.promise().done(e)
      this

    slice: ->
      @pushStack h.apply(this, arguments_)

    first: ->
      @eq 0

    last: ->
      @eq -1

    eq: (e) ->
      t = @length
      n = +e + ((if 0 > e then t else 0))
      @pushStack (if n >= 0 and t > n then [this[n]] else [])

    map: (e) ->
      @pushStack b.map(this, (t, n) ->
        e.call t, n, t
      )

    end: ->
      @prevObject or @constructor(null)

    push: d
    sort: [].sort
    splice: [].splice

  b.fn.init:: = b.fn
  b.extend = b.fn.extend = ->
    e = undefined
    n = undefined
    r = undefined
    i = undefined
    o = undefined
    a = undefined
    s = arguments_[0] or {}
    u = 1
    l = arguments_.length
    c = not 1
    "boolean" is typeof s and (c = s
    s = arguments_[1] or {}
    u = 2
    )
    "object" is typeof s or b.isFunction(s) or (s = {})
    l is u and (s = this
    --u
    )

    while l > u
      unless null is (o = arguments_[u])
        for i of o
          e = s[i]
          r = o[i]
          s isnt r and ((if c and r and (b.isPlainObject(r) or (n = b.isArray(r))) then ((if n then (n = not 1
          a = (if e and b.isArray(e) then e else [])
          ) else a = (if e and b.isPlainObject(e) then e else {}))
          s[i] = b.extend(c, a, r)
          ) else r isnt t and (s[i] = r)))
      u++
    s

  b.extend(
    noConflict: (t) ->
      e.$ is b and (e.$ = u)
      t and e.jQuery is b and (e.jQuery = s)
      b

    isReady: not 1
    readyWait: 1
    holdReady: (e) ->
      (if e then b.readyWait++ else b.ready(not 0))

    ready: (e) ->
      if (if e is not 0 then not --b.readyWait else not b.isReady)
        return setTimeout(b.ready)  unless o.body
        b.isReady = not 0
        e isnt not 0 and --b.readyWait > 0 or (n.resolveWith(o, [b])
        b.fn.trigger and b(o).trigger("ready").off("ready")
        )

    isFunction: (e) ->
      "function" is b.type(e)

    isArray: Array.isArray or (e) ->
      "array" is b.type(e)

    isWindow: (e) ->
      null isnt e and e is e.window

    isNumeric: (e) ->
      not isNaN(parseFloat(e)) and isFinite(e)

    type: (e) ->
      (if null is e then e + "" else (if "object" is typeof e or "function" is typeof e then l[m.call(e)] or "object" else typeof e))

    isPlainObject: (e) ->
      return not 1  if not e or "object" isnt b.type(e) or e.nodeType or b.isWindow(e)
      try
        return not 1  if e.constructor and not y.call(e, "constructor") and not y.call(e.constructor::, "isPrototypeOf")
      catch n
        return not 1
      r = undefined
      for r of e

      r is t or y.call(e, r)

    isEmptyObject: (e) ->
      t = undefined
      for t of e
        return not 1
      not 0

    error: (e) ->
      throw Error(e)

    parseHTML: (e, t, n) ->
      return null  if not e or "string" isnt typeof e
      "boolean" is typeof t and (n = t
      t = not 1
      )
      t = t or o

      r = C.exec(e)
      i = not n and []
      (if r then [t.createElement(r[1])] else (r = b.buildFragment([e], t, i)
      i and b(i).remove()
      b.merge([], r.childNodes)
      ))

    parseJSON: (n) ->
      (if e.JSON and e.JSON.parse then e.JSON.parse(n) else (if null is n then n else (if "string" is typeof n and (n = b.trim(n)
      n and k.test(n.replace(S, "@").replace(A, "]").replace(E, ""))
      ) then Function("return " + n)() else (b.error("Invalid JSON: " + n)
      t
      ))))

    parseXML: (n) ->
      r = undefined
      i = undefined
      return null  if not n or "string" isnt typeof n
      try
        (if e.DOMParser then (i = new DOMParser
        r = i.parseFromString(n, "text/xml")
        ) else (r = new ActiveXObject("Microsoft.XMLDOM")
        r.async = "false"
        r.loadXML(n)
        ))
      catch o
        r = t
      r and r.documentElement and not r.getElementsByTagName("parsererror").length or b.error("Invalid XML: " + n)
      r

    noop: ->

    globalEval: (t) ->
      t and b.trim(t) and (e.execScript or (t) ->
        e.eval.call e, t
      )(t)

    camelCase: (e) ->
      e.replace(j, "ms-").replace D, L

    nodeName: (e, t) ->
      e.nodeName and e.nodeName.toLowerCase() is t.toLowerCase()

    each: (e, t, n) ->
      r = undefined
      i = 0
      o = e.length
      a = M(e)
      if n
        if a
          while o > i
            break  if r = t.apply(e[i], n)
            r is not 1
            i++
        else
          for i of e
            break  if r = t.apply(e[i], n)
            r is not 1
      else if a
        while o > i
          break  if r = t.call(e[i], i, e[i])
          r is not 1
          i++
      else
        for i of e
          break  if r = t.call(e[i], i, e[i])
          r is not 1
      e

    trim: (if v and not v.call("﻿ ") then (e) ->
      (if null is e then "" else v.call(e))
     else (e) ->
      (if null is e then "" else (e + "").replace(T, ""))
    )
    makeArray: (e, t) ->
      n = t or []
      null isnt e and ((if M(Object(e)) then b.merge(n, (if "string" is typeof e then [e] else e)) else d.call(n, e)))
      n

    inArray: (e, t, n) ->
      r = undefined
      if t
        return g.call(t, e, n)  if g
        r = t.length
        n = (if n then (if 0 > n then Math.max(0, r + n) else n) else 0)

        while r > n
          return n  if n of t and t[n] is e
          n++
      -1

    merge: (e, n) ->
      r = n.length
      i = e.length
      o = 0
      if "number" is typeof r
        while r > o
          e[i++] = n[o]
          o++
      else
        e[i++] = n[o++]  while n[o] isnt t
      e.length = i
      e

    grep: (e, t, n) ->
      r = undefined
      i = []
      o = 0
      a = e.length
      n = !!n
      while a > o
        r = !!t(e[o], o)
        n isnt r and i.push(e[o])
        o++
      i

    map: (e, t, n) ->
      r = undefined
      i = 0
      o = e.length
      a = M(e)
      s = []
      if a
        while o > i
          r = t(e[i], i, n)
          null isnt r and (s[s.length] = r)
          i++
      else
        for i of e
          r = t(e[i], i, n)
          null isnt r and (s[s.length] = r)
      f.apply [], s

    guid: 1
    proxy: (e, n) ->
      r = undefined
      i = undefined
      o = undefined
      "string" is typeof n and (o = e[n]
      n = e
      e = o
      )
      (if b.isFunction(e) then (r = h.call(arguments_, 2)
      i = ->
        e.apply n or this, r.concat(h.call(arguments_))

      i.guid = e.guid = e.guid or b.guid++
      i
      ) else t)

    access: (e, n, r, i, o, a, s) ->
      u = 0
      l = e.length
      c = null is r
      if "object" is b.type(r)
        o = not 0
        for u of r
          b.access e, n, u, r[u], not 0, a, s
      else if i isnt t and (o = not 0
      b.isFunction(i) or (s = not 0)
      c and ((if s then (n.call(e, i)
      n = null
      ) else (c = n
      n = (e, t, n) ->
        c.call b(e), n

      )))
      n
      )
        while l > u
          n e[u], r, (if s then i else i.call(e[u], u, n(e[u], r)))
          u++
      (if o then e else (if c then n.call(e) else (if l then n(e[0], r) else a)))

    now: ->
      (new Date).getTime()
  )
  b.ready.promise = (t) ->
    unless n
      if n = b.Deferred()
      "complete" is o.readyState
        setTimeout b.ready
      else unless o.addEventListener
        o.attachEvent("onreadystatechange", H)
        e.attachEvent("onload", H)

        r = not 1
        try
          r = null is e.frameElement and o.documentElement
        r and r.doScroll and a = ->
          unless b.isReady
            try
              r.doScroll "left"
            catch e
              return setTimeout(a, 50)
            q()
            b.ready()
        ()
    n.promise t

  b.each("Boolean Number String Function Array Date RegExp Object Error".split(" "), (e, t) ->
    l["[object " + t + "]"] = t.toLowerCase()
  )

  r = b(o)
  _ = {}
  b.Callbacks = (e) ->
    e = (if "string" is typeof e then _[e] or F(e) else b.extend({}, e))
    n = undefined
    r = undefined
    i = undefined
    o = undefined
    a = undefined
    s = undefined
    u = []
    l = not e.once and []
    c = (t) ->
      r = e.memory and t
      i = not 0
      a = s or 0
      s = 0
      o = u.length
      n = not 0

      while u and o > a
        if u[a].apply(t[0], t[1]) is not 1 and e.stopOnFalse
          r = not 1
          break
        a++
      n = not 1
      u and ((if l then l.length and c(l.shift()) else (if r then u = [] else p.disable())))

    p =
      add: ->
        if u
          t = u.length
          (i = (t) ->
            b.each t, (t, n) ->
              r = b.type(n)
              (if "function" is r then e.unique and p.has(n) or u.push(n) else n and n.length and "string" isnt r and i(n))

          )(arguments_)
          (if n then o = u.length else r and (s = t
          c(r)
          ))
        this

      remove: ->
        u and b.each(arguments_, (e, t) ->
          r = undefined
          while (r = b.inArray(t, u, r)) > -1
            u.splice(r, 1)
            n and (o >= r and o--
            a >= r and a--
            )
        )
        this

      has: (e) ->
        (if e then b.inArray(e, u) > -1 else not (not u or not u.length))

      empty: ->
        u = []
        this

      disable: ->
        u = l = r = t
        this

      disabled: ->
        not u

      lock: ->
        l = t
        r or p.disable()
        this

      locked: ->
        not l

      fireWith: (e, t) ->
        t = t or []
        t = [e, (if t.slice then t.slice() else t)]
        not u or i and not l or ((if n then l.push(t) else c(t)))
        this

      fire: ->
        p.fireWith(this, arguments_)
        this

      fired: ->
        !!i

    p

  b.extend(
    Deferred: (e) ->
      t = [["resolve", "done", b.Callbacks("once memory"), "resolved"], ["reject", "fail", b.Callbacks("once memory"), "rejected"], ["notify", "progress", b.Callbacks("memory")]]
      n = "pending"
      r =
        state: ->
          n

        always: ->
          i.done(arguments_).fail(arguments_)
          this

        then: ->
          e = arguments_
          b.Deferred((n) ->
            b.each(t, (t, o) ->
              a = o[0]
              s = b.isFunction(e[t]) and e[t]
              i[o[1]] ->
                e = s and s.apply(this, arguments_)
                (if e and b.isFunction(e.promise) then e.promise().done(n.resolve).fail(n.reject).progress(n.notify) else n[a + "With"]((if this is r then n.promise() else this), (if s then [e] else arguments_)))

            )
            e = null
          ).promise()

        promise: (e) ->
          (if null isnt e then b.extend(e, r) else r)

      i = {}
      r.pipe = r.then
      b.each(t, (e, o) ->
        a = o[2]
        s = o[3]
        r[o[1]] = a.add
        s and a.add(->
          n = s
        , t[1 ^ e][2].disable, t[2][2].lock)
        i[o[0]] = ->
          i[o[0] + "With"]((if this is i then r else this), arguments_)
          this

        i[o[0] + "With"] = a.fireWith
      )
      r.promise(i)
      e and e.call(i, i)
      i

    when: (e) ->
      t = 0
      n = h.call(arguments_)
      r = n.length
      i = (if 1 isnt r or e and b.isFunction(e.promise) then r else 0)
      o = (if 1 is i then e else b.Deferred())
      a = (e, t, n) ->
        (r) ->
          t[e] = this
          n[e] = (if arguments_.length > 1 then h.call(arguments_) else r)
          (if n is s then o.notifyWith(t, n) else --i or o.resolveWith(t, n))

      s = undefined
      u = undefined
      l = undefined
      if r > 1
        s = Array(r)
        u = Array(r)
        l = Array(r)

        while r > t
          (if n[t] and b.isFunction(n[t].promise) then n[t].promise().done(a(t, l, n)).fail(o.reject).progress(a(t, u, s)) else --i)
          t++
      i or o.resolveWith(l, n)
      o.promise()
  )
  b.support = ->
    t = undefined
    n = undefined
    r = undefined
    a = undefined
    s = undefined
    u = undefined
    l = undefined
    c = undefined
    p = undefined
    f = undefined
    d = o.createElement("div")
    return {}  if d.setAttribute("className", "t")
    d.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>"
    n = d.getElementsByTagName("*")
    r = d.getElementsByTagName("a")[0]
    not n or not r or not n.length

    s = o.createElement("select")
    l = s.appendChild(o.createElement("option"))
    a = d.getElementsByTagName("input")[0]
    r.style.cssText = "top:1px;float:left;opacity:.5"
    t =
      getSetAttribute: "t" isnt d.className
      leadingWhitespace: 3 is d.firstChild.nodeType
      tbody: not d.getElementsByTagName("tbody").length
      htmlSerialize: !!d.getElementsByTagName("link").length
      style: /top/.test(r.getAttribute("style"))
      hrefNormalized: "/a" is r.getAttribute("href")
      opacity: /^0.5/.test(r.style.opacity)
      cssFloat: !!r.style.cssFloat
      checkOn: !!a.value
      optSelected: l.selected
      enctype: !!o.createElement("form").enctype
      html5Clone: "<:nav></:nav>" isnt o.createElement("nav").cloneNode(not 0).outerHTML
      boxModel: "CSS1Compat" is o.compatMode
      deleteExpando: not 0
      noCloneEvent: not 0
      inlineBlockNeedsLayout: not 1
      shrinkWrapBlocks: not 1
      reliableMarginRight: not 0
      boxSizingReliable: not 0
      pixelPosition: not 1

    a.checked = not 0
    t.noCloneChecked = a.cloneNode(not 0).checked
    s.disabled = not 0
    t.optDisabled = not l.disabled

    try
      delete d.test
    catch h
      t.deleteExpando = not 1
    a = o.createElement("input")
    a.setAttribute("value", "")
    t.input = "" is a.getAttribute("value")
    a.value = "t"
    a.setAttribute("type", "radio")
    t.radioValue = "t" is a.value
    a.setAttribute("checked", "t")
    a.setAttribute("name", "t")
    u = o.createDocumentFragment()
    u.appendChild(a)
    t.appendChecked = a.checked
    t.checkClone = u.cloneNode(not 0).cloneNode(not 0).lastChild.checked
    d.attachEvent and (d.attachEvent("onclick", ->
      t.noCloneEvent = not 1
    )
    d.cloneNode(not 0).click()
    )

    for f of
      submit: not 0
      change: not 0
      focusin: not 0
      d.setAttribute(c = "on" + f, "t")
      t[f + "Bubbles"] = c of e or d.attributes[c].expando is not 1
    d.style.backgroundClip = "content-box"
    d.cloneNode(not 0).style.backgroundClip = ""
    t.clearCloneStyle = "content-box" is d.style.backgroundClip
    b(->
      n = undefined
      r = undefined
      a = undefined
      s = "padding:0;margin:0;border:0;display:block;box-sizing:content-box;-moz-box-sizing:content-box;-webkit-box-sizing:content-box;"
      u = o.getElementsByTagName("body")[0]
      u and (n = o.createElement("div")
      n.style.cssText = "border:0;width:0;height:0;position:absolute;top:0;left:-9999px;margin-top:1px"
      u.appendChild(n).appendChild(d)
      d.innerHTML = "<table><tr><td></td><td>t</td></tr></table>"
      a = d.getElementsByTagName("td")
      a[0].style.cssText = "padding:0;margin:0;border:0;display:none"
      p = 0 is a[0].offsetHeight
      a[0].style.display = ""
      a[1].style.display = "none"
      t.reliableHiddenOffsets = p and 0 is a[0].offsetHeight
      d.innerHTML = ""
      d.style.cssText = "box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;padding:1px;border:1px;display:block;width:4px;margin-top:1%;position:absolute;top:1%;"
      t.boxSizing = 4 is d.offsetWidth
      t.doesNotIncludeMarginInBodyOffset = 1 isnt u.offsetTop
      e.getComputedStyle and (t.pixelPosition = "1%" isnt (e.getComputedStyle(d, null) or {}).top
      t.boxSizingReliable = "4px" is (e.getComputedStyle(d, null) or width: "4px").width
      r = d.appendChild(o.createElement("div"))
      r.style.cssText = d.style.cssText = s
      r.style.marginRight = r.style.width = "0"
      d.style.width = "1px"
      t.reliableMarginRight = not parseFloat((e.getComputedStyle(r, null) or {}).marginRight)
      )
      typeof d.style.zoom isnt i and (d.innerHTML = ""
      d.style.cssText = s + "width:1px;padding:1px;display:inline;zoom:1"
      t.inlineBlockNeedsLayout = 3 is d.offsetWidth
      d.style.display = "block"
      d.innerHTML = "<div></div>"
      d.firstChild.style.width = "5px"
      t.shrinkWrapBlocks = 3 isnt d.offsetWidth
      t.inlineBlockNeedsLayout and (u.style.zoom = 1)
      )
      u.removeChild(n)
      n = d = a = r = null
      )
    )
    n = s = u = l = r = a = null
    t
  ()

  O = /(?:\{[\s\S]*\}|\[[\s\S]*\])$/
  B = /([A-Z])/g
  b.extend(
    cache: {}
    expando: "jQuery" + (p + Math.random()).replace(/\D/g, "")
    noData:
      embed: not 0
      object: "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
      applet: not 0

    hasData: (e) ->
      e = (if e.nodeType then b.cache[e[b.expando]] else e[b.expando])
      !!e and not $(e)

    data: (e, t, n) ->
      P e, t, n

    removeData: (e, t) ->
      R e, t

    _data: (e, t, n) ->
      P e, t, n, not 0

    _removeData: (e, t) ->
      R e, t, not 0

    acceptData: (e) ->
      return not 1  if e.nodeType and 1 isnt e.nodeType and 9 isnt e.nodeType
      t = e.nodeName and b.noData[e.nodeName.toLowerCase()]
      not t or t isnt not 0 and e.getAttribute("classid") is t
  )
  b.fn.extend(
    data: (e, n) ->
      r = undefined
      i = undefined
      o = this[0]
      a = 0
      s = null
      if e is t
        if @length and (s = b.data(o)
        1 is o.nodeType and not b._data(o, "parsedAttrs")
        )
          r = o.attributes
          while r.length > a
            i = r[a].name
            i.indexOf("data-") or (i = b.camelCase(i.slice(5))
            W(o, i, s[i])
            )
            a++
          b._data o, "parsedAttrs", not 0
        return s
      (if "object" is typeof e then @each(->
        b.data this, e
      ) else b.access(this, (n) ->
        (if n is t then (if o then W(o, e, b.data(o, e)) else null) else (@each(->
          b.data this, e, n
        )
        t
        ))
      , null, n, arguments_.length > 1, null, not 0))

    removeData: (e) ->
      @each ->
        b.removeData this, e

  )

  b.extend(
    queue: (e, n, r) ->
      i = undefined
      (if e then (n = (n or "fx") + "queue"
      i = b._data(e, n)
      r and ((if not i or b.isArray(r) then i = b._data(e, n, b.makeArray(r)) else i.push(r)))
      i or []
      ) else t)

    dequeue: (e, t) ->
      t = t or "fx"
      n = b.queue(e, t)
      r = n.length
      i = n.shift()
      o = b._queueHooks(e, t)
      a = ->
        b.dequeue e, t

      "inprogress" is i and (i = n.shift()
      r--
      )
      o.cur = i
      i and ("fx" is t and n.unshift("inprogress")
      delete o.stop

      i.call(e, a, o)
      )
      not r and o and o.empty.fire()

    _queueHooks: (e, t) ->
      n = t + "queueHooks"
      b._data(e, n) or b._data(e, n,
        empty: b.Callbacks("once memory").add(->
          b._removeData(e, t + "queue")
          b._removeData(e, n)
        )
      )
  )
  b.fn.extend(
    queue: (e, n) ->
      r = 2
      "string" isnt typeof e and (n = e
      e = "fx"
      r--
      )
      (if r > arguments_.length then b.queue(this[0], e) else (if n is t then this else @each(->
        t = b.queue(this, e, n)
        b._queueHooks(this, e)
        "fx" is e and "inprogress" isnt t[0] and b.dequeue(this, e)
      )))

    dequeue: (e) ->
      @each ->
        b.dequeue this, e


    delay: (e, t) ->
      e = (if b.fx then b.fx.speeds[e] or e else e)
      t = t or "fx"
      @queue(t, (t, n) ->
        r = setTimeout(t, e)
        n.stop = ->
          clearTimeout r
      )

    clearQueue: (e) ->
      @queue e or "fx", []

    promise: (e, n) ->
      r = undefined
      i = 1
      o = b.Deferred()
      a = this
      s = @length
      u = ->
        --i or o.resolveWith(a, [a])

      "string" isnt typeof e and (n = e
      e = t
      )
      e = e or "fx"

      while s--
        r = b._data(a[s], e + "queueHooks")
        r and r.empty and (i++
        r.empty.add(u)
        )
      u()
      o.promise(n)
  )

  I = undefined
  z = undefined
  X = /[\t\r\n]/g
  U = /\r/g
  V = /^(?:input|select|textarea|button|object)$/i
  Y = /^(?:a|area)$/i
  J = /^(?:checked|selected|autofocus|autoplay|async|controls|defer|disabled|hidden|loop|multiple|open|readonly|required|scoped)$/i
  G = /^(?:checked|selected)$/i
  Q = b.support.getSetAttribute
  K = b.support.input
  b.fn.extend(
    attr: (e, t) ->
      b.access this, b.attr, e, t, arguments_.length > 1

    removeAttr: (e) ->
      @each ->
        b.removeAttr this, e


    prop: (e, t) ->
      b.access this, b.prop, e, t, arguments_.length > 1

    removeProp: (e) ->
      e = b.propFix[e] or e
      @each(->
        try
          this[e] = t
          delete this[e]
      )

    addClass: (e) ->
      t = undefined
      n = undefined
      r = undefined
      i = undefined
      o = undefined
      a = 0
      s = @length
      u = "string" is typeof e and e
      if b.isFunction(e)
        return @each((t) ->
          b(this).addClass e.call(this, t, @className)
        )
      if u
        t = (e or "").match(w) or []
        while s > a
          if n = this[a]
          r = 1 is n.nodeType and ((if n.className then (" " + n.className + " ").replace(X, " ") else " "))
            o = 0
            0 > r.indexOf(" " + i + " ") and (r += i + " ")  while i = t[o++]
            n.className = b.trim(r)
          a++
      this

    removeClass: (e) ->
      t = undefined
      n = undefined
      r = undefined
      i = undefined
      o = undefined
      a = 0
      s = @length
      u = 0 is arguments_.length or "string" is typeof e and e
      if b.isFunction(e)
        return @each((t) ->
          b(this).removeClass e.call(this, t, @className)
        )
      if u
        t = (e or "").match(w) or []
        while s > a
          if n = this[a]
          r = 1 is n.nodeType and ((if n.className then (" " + n.className + " ").replace(X, " ") else ""))
            o = 0
            r = r.replace(" " + i + " ", " ")  while r.indexOf(" " + i + " ") >= 0  while i = t[o++]
            n.className = (if e then b.trim(r) else "")
          a++
      this

    toggleClass: (e, t) ->
      n = typeof e
      r = "boolean" is typeof t
      (if b.isFunction(e) then @each((n) ->
        b(this).toggleClass e.call(this, n, @className, t), t
      ) else @each(->
        if "string" is n
          o = undefined
          a = 0
          s = b(this)
          u = t
          l = e.match(w) or []
          while o = l[a++]
            u = (if r then u else not s.hasClass(o))
            s[(if u then "addClass" else "removeClass")](o)
        else
          (n is i or "boolean" is n) and (@className and b._data(this, "__className__", @className)
          @className = (if @className or e is not 1 then "" else b._data(this, "__className__") or "")
          )
      ))

    hasClass: (e) ->
      t = " " + e + " "
      n = 0
      r = @length
      while r > n
        return not 0  if 1 is this[n].nodeType and (" " + this[n].className + " ").replace(X, " ").indexOf(t) >= 0
        n++
      not 1

    val: (e) ->
      n = undefined
      r = undefined
      i = undefined
      o = this[0]
      if arguments_.length
        return i = b.isFunction(e)
        @each((n) ->
          o = undefined
          a = b(this)
          1 is @nodeType and (o = (if i then e.call(this, n, a.val()) else e)
          (if null is o then o = "" else (if "number" is typeof o then o += "" else b.isArray(o) and (o = b.map(o, (e) ->
            (if null is e then "" else e + "")
          ))))
          r = b.valHooks[@type] or b.valHooks[@nodeName.toLowerCase()]
          r and "set" of r and r.set(this, o, "value") isnt t or (@value = o)
          )
        )
      if o
        r = b.valHooks[o.type] or b.valHooks[o.nodeName.toLowerCase()]
        (if r and "get" of r and (n = r.get(o, "value")) isnt t then n else (n = o.value
        (if "string" is typeof n then n.replace(U, "") else (if null is n then "" else n))
        ))
  )
  b.extend(
    valHooks:
      option:
        get: (e) ->
          t = e.attributes.value
          (if not t or t.specified then e.value else e.text)

      select:
        get: (e) ->
          t = undefined
          n = undefined
          r = e.options
          i = e.selectedIndex
          o = "select-one" is e.type or 0 > i
          a = (if o then null else [])
          s = (if o then i + 1 else r.length)
          u = (if 0 > i then s else (if o then i else 0))
          while s > u
            if n = r[u]
            not (not n.selected and u isnt i or ((if b.support.optDisabled then n.disabled else null isnt n.getAttribute("disabled"))) or n.parentNode.disabled and b.nodeName(n.parentNode, "optgroup"))
              return t  if t = b(n).val()
              o

              a.push t
            u++
          a

        set: (e, t) ->
          n = b.makeArray(t)
          b(e).find("option").each(->
            @selected = b.inArray(b(this).val(), n) >= 0
          )
          n.length or (e.selectedIndex = -1)
          n

    attr: (e, n, r) ->
      o = undefined
      a = undefined
      s = undefined
      u = e.nodeType
      if e and 3 isnt u and 8 isnt u and 2 isnt u
        (if typeof e.getAttribute is i then b.prop(e, n, r) else (a = 1 isnt u or not b.isXMLDoc(e)
        a and (n = n.toLowerCase()
        o = b.attrHooks[n] or ((if J.test(n) then z else I))
        )
        (if r is t then (if o and a and "get" of o and null isnt (s = o.get(e, n)) then s else (typeof e.getAttribute isnt i and (s = e.getAttribute(n))
        (if null is s then t else s)
        )) else (if null isnt r then (if o and a and "set" of o and (s = o.set(e, r, n)) isnt t then s else (e.setAttribute(n, r + "")
        r
        )) else (b.removeAttr(e, n)
        t
        )))
        ))

    removeAttr: (e, t) ->
      n = undefined
      r = undefined
      i = 0
      o = t and t.match(w)
      if o and 1 is e.nodeType
        while n = o[i++]
          r = b.propFix[n] or n
          (if J.test(n) then (if not Q and G.test(n) then e[b.camelCase("default-" + n)] = e[r] = not 1 else e[r] = not 1) else b.attr(e, n, ""))
          e.removeAttribute((if Q then n else r))

    attrHooks:
      type:
        set: (e, t) ->
          if not b.support.radioValue and "radio" is t and b.nodeName(e, "input")
            n = e.value
            e.setAttribute("type", t)
            n and (e.value = n)
            t

    propFix:
      tabindex: "tabIndex"
      readonly: "readOnly"
      for: "htmlFor"
      class: "className"
      maxlength: "maxLength"
      cellspacing: "cellSpacing"
      cellpadding: "cellPadding"
      rowspan: "rowSpan"
      colspan: "colSpan"
      usemap: "useMap"
      frameborder: "frameBorder"
      contenteditable: "contentEditable"

    prop: (e, n, r) ->
      i = undefined
      o = undefined
      a = undefined
      s = e.nodeType
      if e and 3 isnt s and 8 isnt s and 2 isnt s
        a = 1 isnt s or not b.isXMLDoc(e)
        a and (n = b.propFix[n] or n
        o = b.propHooks[n]
        )
        (if r isnt t then (if o and "set" of o and (i = o.set(e, r, n)) isnt t then i else e[n] = r) else (if o and "get" of o and null isnt (i = o.get(e, n)) then i else e[n]))

    propHooks:
      tabIndex:
        get: (e) ->
          n = e.getAttributeNode("tabindex")
          (if n and n.specified then parseInt(n.value, 10) else (if V.test(e.nodeName) or Y.test(e.nodeName) and e.href then 0 else t))
  )
  z =
    get: (e, n) ->
      r = b.prop(e, n)
      i = "boolean" is typeof r and e.getAttribute(n)
      o = (if "boolean" is typeof r then (if K and Q then null isnt i else (if G.test(n) then e[b.camelCase("default-" + n)] else !!i)) else e.getAttributeNode(n))
      (if o and o.value isnt not 1 then n.toLowerCase() else t)

    set: (e, t, n) ->
      (if t is not 1 then b.removeAttr(e, n) else (if K and Q or not G.test(n) then e.setAttribute(not Q and b.propFix[n] or n, n) else e[b.camelCase("default-" + n)] = e[n] = not 0))
      n

  K and Q or (b.attrHooks.value =
    get: (e, n) ->
      r = e.getAttributeNode(n)
      (if b.nodeName(e, "input") then e.defaultValue else (if r and r.specified then r.value else t))

    set: (e, n, r) ->
      (if b.nodeName(e, "input") then (e.defaultValue = n
      t
      ) else I and I.set(e, n, r))
  )
  Q or (I = b.valHooks.button =
    get: (e, n) ->
      r = e.getAttributeNode(n)
      (if r and ((if "id" is n or "name" is n or "coords" is n then "" isnt r.value else r.specified)) then r.value else t)

    set: (e, n, r) ->
      i = e.getAttributeNode(r)
      i or e.setAttributeNode(i = e.ownerDocument.createAttribute(r))
      i.value = n += ""
      (if "value" is r or n is e.getAttribute(r) then n else t)

  b.attrHooks.contenteditable =
    get: I.get
    set: (e, t, n) ->
      I.set e, (if "" is t then not 1 else t), n

  b.each(["width", "height"], (e, n) ->
    b.attrHooks[n] = b.extend(b.attrHooks[n],
      set: (e, r) ->
        (if "" is r then (e.setAttribute(n, "auto")
        r
        ) else t)
    )
  )
  )
  b.support.hrefNormalized or (b.each(["href", "src", "width", "height"], (e, n) ->
    b.attrHooks[n] = b.extend(b.attrHooks[n],
      get: (e) ->
        r = e.getAttribute(n, 2)
        (if null is r then t else r)
    )
  )
  b.each(["href", "src"], (e, t) ->
    b.propHooks[t] = get: (e) ->
      e.getAttribute t, 4
  )
  )
  b.support.style or (b.attrHooks.style =
    get: (e) ->
      e.style.cssText or t

    set: (e, t) ->
      e.style.cssText = t + ""
  )
  b.support.optSelected or (b.propHooks.selected = b.extend(b.propHooks.selected,
    get: (e) ->
      t = e.parentNode
      t and (t.selectedIndex
      t.parentNode and t.parentNode.selectedIndex
      )
      null
  ))
  b.support.enctype or (b.propFix.enctype = "encoding")
  b.support.checkOn or b.each(["radio", "checkbox"], ->
    b.valHooks[this] = get: (e) ->
      (if null is e.getAttribute("value") then "on" else e.value)
  )
  b.each(["radio", "checkbox"], ->
    b.valHooks[this] = b.extend(b.valHooks[this],
      set: (e, n) ->
        (if b.isArray(n) then e.checked = b.inArray(b(e).val(), n) >= 0 else t)
    )
  )

  Z = /^(?:input|select|textarea)$/i
  et = /^key/
  tt = /^(?:mouse|contextmenu)|click/
  nt = /^(?:focusinfocus|focusoutblur)$/
  rt = /^([^.]*)(?:\.(.+)|)$/
  b.event =
    global: {}
    add: (e, n, r, o, a) ->
      s = undefined
      u = undefined
      l = undefined
      c = undefined
      p = undefined
      f = undefined
      d = undefined
      h = undefined
      g = undefined
      m = undefined
      y = undefined
      v = b._data(e)
      if v
        r.handler and (c = r
        r = c.handler
        a = c.selector
        )
        r.guid or (r.guid = b.guid++)
        (u = v.events) or (u = v.events = {})
        (f = v.handle) or (f = v.handle = (e) ->
          (if typeof b is i or e and b.event.triggered is e.type then t else b.event.dispatch.apply(f.elem, arguments_))

        f.elem = e
        )
        n = (n or "").match(w) or [""]
        l = n.length

        while l--
          s = rt.exec(n[l]) or []
          g = y = s[1]
          m = (s[2] or "").split(".").sort()
          p = b.event.special[g] or {}
          g = ((if a then p.delegateType else p.bindType)) or g
          p = b.event.special[g] or {}
          d = b.extend(
            type: g
            origType: y
            data: o
            handler: r
            guid: r.guid
            selector: a
            needsContext: a and b.expr.match.needsContext.test(a)
            namespace: m.join(".")
          , c)
          (h = u[g]) or (h = u[g] = []
          h.delegateCount = 0
          p.setup and p.setup.call(e, o, m, f) isnt not 1 or ((if e.addEventListener then e.addEventListener(g, f, not 1) else e.attachEvent and e.attachEvent("on" + g, f)))
          )
          p.add and (p.add.call(e, d)
          d.handler.guid or (d.handler.guid = r.guid)
          )
          (if a then h.splice(h.delegateCount++, 0, d) else h.push(d))
          b.event.global[g] = not 0
        e = null

    remove: (e, t, n, r, i) ->
      o = undefined
      a = undefined
      s = undefined
      u = undefined
      l = undefined
      c = undefined
      p = undefined
      f = undefined
      d = undefined
      h = undefined
      g = undefined
      m = b.hasData(e) and b._data(e)
      if m and (c = m.events)
        t = (t or "").match(w) or [""]
        l = t.length

        while l--
          if s = rt.exec(t[l]) or []
          d = g = s[1]
          h = (s[2] or "").split(".").sort()
          d
            p = b.event.special[d] or {}
            d = ((if r then p.delegateType else p.bindType)) or d
            f = c[d] or []
            s = s[2] and RegExp("(^|\\.)" + h.join("\\.(?:.*\\.|)") + "(\\.|$)")
            u = o = f.length

            while o--
              a = f[o]
              not i and g isnt a.origType or n and n.guid isnt a.guid or s and not s.test(a.namespace) or r and r isnt a.selector and ("**" isnt r or not a.selector) or (f.splice(o, 1)
              a.selector and f.delegateCount--
              p.remove and p.remove.call(e, a)
              )
            u and not f.length and (p.teardown and p.teardown.call(e, h, m.handle) isnt not 1 or b.removeEvent(e, d, m.handle)
            delete c[d]

            )
          else
            for d of c
              b.event.remove e, d + t[l], n, r, not 0
        b.isEmptyObject(c) and (delete m.handle

        b._removeData(e, "events")
        )

    trigger: (n, r, i, a) ->
      s = undefined
      u = undefined
      l = undefined
      c = undefined
      p = undefined
      f = undefined
      d = undefined
      h = [i or o]
      g = (if y.call(n, "type") then n.type else n)
      m = (if y.call(n, "namespace") then n.namespace.split(".") else [])
      if l = f = i = i or o
      3 isnt i.nodeType and 8 isnt i.nodeType and not nt.test(g + b.event.triggered) and (g.indexOf(".") >= 0 and (m = g.split(".")
      g = m.shift()
      m.sort()
      )
      u = 0 > g.indexOf(":") and "on" + g
      n = (if n[b.expando] then n else new b.Event(g, "object" is typeof n and n))
      n.isTrigger = not 0
      n.namespace = m.join(".")
      n.namespace_re = (if n.namespace then RegExp("(^|\\.)" + m.join("\\.(?:.*\\.|)") + "(\\.|$)") else null)
      n.result = t
      n.target or (n.target = i)
      r = (if null is r then [n] else b.makeArray(r, [n]))
      p = b.event.special[g] or {}
      a or not p.trigger or p.trigger.apply(i, r) isnt not 1
      )
        if not a and not p.noBubble and not b.isWindow(i)
          c = p.delegateType or g
          nt.test(c + g) or (l = l.parentNode)

          while l
            h.push(l)
            f = l
            l = l.parentNode
          f is (i.ownerDocument or o) and h.push(f.defaultView or f.parentWindow or e)
        d = 0
        while (l = h[d++]) and not n.isPropagationStopped()
          n.type = (if d > 1 then c else p.bindType or g)
          s = (b._data(l, "events") or {})[n.type] and b._data(l, "handle")
          s and s.apply(l, r)
          s = u and l[u]
          s and b.acceptData(l) and s.apply and s.apply(l, r) is not 1 and n.preventDefault()
        if n.type = g
        not (a or n.isDefaultPrevented() or p._default and p._default.apply(i.ownerDocument, r) isnt not 1 or "click" is g and b.nodeName(i, "a") or not b.acceptData(i) or not u or not i[g] or b.isWindow(i))
          f = i[u]
          f and (i[u] = null)
          b.event.triggered = g

          try
            i[g]()
          b.event.triggered = t
          f and (i[u] = f)
        n.result

    dispatch: (e) ->
      e = b.event.fix(e)
      n = undefined
      r = undefined
      i = undefined
      o = undefined
      a = undefined
      s = []
      u = h.call(arguments_)
      l = (b._data(this, "events") or {})[e.type] or []
      c = b.event.special[e.type] or {}
      if u[0] = e
      e.delegateTarget = this
      not c.preDispatch or c.preDispatch.call(this, e) isnt not 1
        s = b.event.handlers.call(this, e, l)
        n = 0

        while (o = s[n++]) and not e.isPropagationStopped()
          e.currentTarget = o.elem
          a = 0

          while (i = o.handlers[a++]) and not e.isImmediatePropagationStopped()
            (not e.namespace_re or e.namespace_re.test(i.namespace)) and (e.handleObj = i
            e.data = i.data
            r = ((b.event.special[i.origType] or {}).handle or i.handler).apply(o.elem, u)
            r isnt t and (e.result = r) is not 1 and (e.preventDefault()
            e.stopPropagation()
            )
            )
        c.postDispatch and c.postDispatch.call(this, e)
        e.result

    handlers: (e, n) ->
      r = undefined
      i = undefined
      o = undefined
      a = undefined
      s = []
      u = n.delegateCount
      l = e.target
      if u and l.nodeType and (not e.button or "click" isnt e.type)
        while l isnt this
          if 1 is l.nodeType and (l.disabled isnt not 0 or "click" isnt e.type)
            o = []
            a = 0

            while u > a
              i = n[a]
              r = i.selector + " "
              o[r] is t and (o[r] = (if i.needsContext then b(r, this).index(l) >= 0 else b.find(r, this, null, [l]).length))
              o[r] and o.push(i)
              a++
            o.length and s.push(
              elem: l
              handlers: o
            )
          l = l.parentNode or this
      n.length > u and s.push(
        elem: this
        handlers: n.slice(u)
      )
      s

    fix: (e) ->
      return e  if e[b.expando]
      t = undefined
      n = undefined
      r = undefined
      i = e.type
      a = e
      s = @fixHooks[i]
      s or (@fixHooks[i] = s = (if tt.test(i) then @mouseHooks else (if et.test(i) then @keyHooks else {})))
      r = (if s.props then @props.concat(s.props) else @props)
      e = new b.Event(a)
      t = r.length

      while t--
        n = r[t]
        e[n] = a[n]
      e.target or (e.target = a.srcElement or o)
      3 is e.target.nodeType and (e.target = e.target.parentNode)
      e.metaKey = !!e.metaKey
      (if s.filter then s.filter(e, a) else e)

    props: "altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" ")
    fixHooks: {}
    keyHooks:
      props: "char charCode key keyCode".split(" ")
      filter: (e, t) ->
        null is e.which and (e.which = (if null isnt t.charCode then t.charCode else t.keyCode))
        e

    mouseHooks:
      props: "button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" ")
      filter: (e, n) ->
        r = undefined
        i = undefined
        a = undefined
        s = n.button
        u = n.fromElement
        null is e.pageX and null isnt n.clientX and (i = e.target.ownerDocument or o
        a = i.documentElement
        r = i.body
        e.pageX = n.clientX + (a and a.scrollLeft or r and r.scrollLeft or 0) - (a and a.clientLeft or r and r.clientLeft or 0)
        e.pageY = n.clientY + (a and a.scrollTop or r and r.scrollTop or 0) - (a and a.clientTop or r and r.clientTop or 0)
        )
        not e.relatedTarget and u and (e.relatedTarget = (if u is e.target then n.toElement else u))
        e.which or s is t or (e.which = (if 1 & s then 1 else (if 2 & s then 3 else (if 4 & s then 2 else 0))))
        e

    special:
      load:
        noBubble: not 0

      click:
        trigger: ->
          (if b.nodeName(this, "input") and "checkbox" is @type and @click then (@click()
          not 1
          ) else t)

      focus:
        trigger: ->
          if this isnt o.activeElement and @focus
            try
              return @focus()
              not 1

        delegateType: "focusin"

      blur:
        trigger: ->
          (if this is o.activeElement and @blur then (@blur()
          not 1
          ) else t)

        delegateType: "focusout"

      beforeunload:
        postDispatch: (e) ->
          e.result isnt t and (e.originalEvent.returnValue = e.result)

    simulate: (e, t, n, r) ->
      i = b.extend(new b.Event, n,
        type: e
        isSimulated: not 0
        originalEvent: {}
      )
      (if r then b.event.trigger(i, null, t) else b.event.dispatch.call(t, i))
      i.isDefaultPrevented() and n.preventDefault()

  b.removeEvent = (if o.removeEventListener then (e, t, n) ->
    e.removeEventListener and e.removeEventListener(t, n, not 1)
   else (e, t, n) ->
    r = "on" + t
    e.detachEvent and (typeof e[r] is i and (e[r] = null)
    e.detachEvent(r, n)
    )
  )
  b.Event = (e, n) ->
    (if this instanceof b.Event then ((if e and e.type then (@originalEvent = e
    @type = e.type
    @isDefaultPrevented = (if e.defaultPrevented or e.returnValue is not 1 or e.getPreventDefault and e.getPreventDefault() then it else ot)
    ) else @type = e)
    n and b.extend(this, n)
    @timeStamp = e and e.timeStamp or b.now()
    this[b.expando] = not 0
    t
    ) else new b.Event(e, n))

  b.Event:: =
    isDefaultPrevented: ot
    isPropagationStopped: ot
    isImmediatePropagationStopped: ot
    preventDefault: ->
      e = @originalEvent
      @isDefaultPrevented = it
      e and ((if e.preventDefault then e.preventDefault() else e.returnValue = not 1))

    stopPropagation: ->
      e = @originalEvent
      @isPropagationStopped = it
      e and (e.stopPropagation and e.stopPropagation()
      e.cancelBubble = not 0
      )

    stopImmediatePropagation: ->
      @isImmediatePropagationStopped = it
      @stopPropagation()

  b.each(
    mouseenter: "mouseover"
    mouseleave: "mouseout"
  , (e, t) ->
    b.event.special[e] =
      delegateType: t
      bindType: t
      handle: (e) ->
        n = undefined
        r = this
        i = e.relatedTarget
        o = e.handleObj
        (not i or i isnt r and not b.contains(r, i)) and (e.type = o.origType
        n = o.handler.apply(this, arguments_)
        e.type = t
        )
        n
  )
  b.support.submitBubbles or (b.event.special.submit =
    setup: ->
      (if b.nodeName(this, "form") then not 1 else (b.event.add(this, "click._submit keypress._submit", (e) ->
        n = e.target
        r = (if b.nodeName(n, "input") or b.nodeName(n, "button") then n.form else t)
        r and not b._data(r, "submitBubbles") and (b.event.add(r, "submit._submit", (e) ->
          e._submit_bubble = not 0
        )
        b._data(r, "submitBubbles", not 0)
        )
      )
      t
      ))

    postDispatch: (e) ->
      e._submit_bubble and (delete e._submit_bubble

      @parentNode and not e.isTrigger and b.event.simulate("submit", @parentNode, e, not 0)
      )

    teardown: ->
      (if b.nodeName(this, "form") then not 1 else (b.event.remove(this, "._submit")
      t
      ))
  )
  b.support.changeBubbles or (b.event.special.change =
    setup: ->
      (if Z.test(@nodeName) then (("checkbox" is @type or "radio" is @type) and (b.event.add(this, "propertychange._change", (e) ->
        "checked" is e.originalEvent.propertyName and (@_just_changed = not 0)
      )
      b.event.add(this, "click._change", (e) ->
        @_just_changed and not e.isTrigger and (@_just_changed = not 1)
        b.event.simulate("change", this, e, not 0)
      )
      )
      not 1
      ) else (b.event.add(this, "beforeactivate._change", (e) ->
        t = e.target
        Z.test(t.nodeName) and not b._data(t, "changeBubbles") and (b.event.add(t, "change._change", (e) ->
          not @parentNode or e.isSimulated or e.isTrigger or b.event.simulate("change", @parentNode, e, not 0)
        )
        b._data(t, "changeBubbles", not 0)
        )
      )
      t
      ))

    handle: (e) ->
      n = e.target
      (if this isnt n or e.isSimulated or e.isTrigger or "radio" isnt n.type and "checkbox" isnt n.type then e.handleObj.handler.apply(this, arguments_) else t)

    teardown: ->
      b.event.remove(this, "._change")
      not Z.test(@nodeName)
  )
  b.support.focusinBubbles or b.each(
    focus: "focusin"
    blur: "focusout"
  , (e, t) ->
    n = 0
    r = (e) ->
      b.event.simulate t, e.target, b.event.fix(e), not 0

    b.event.special[t] =
      setup: ->
        0 is n++ and o.addEventListener(e, r, not 0)

      teardown: ->
        0 is --n and o.removeEventListener(e, r, not 0)
  )
  b.fn.extend(
    on: (e, n, r, i, o) ->
      a = undefined
      s = undefined
      if "object" is typeof e
        "string" isnt typeof n and (r = r or n
        n = t
        )
        for a of e
          @on a, n, r, e[a], o
        return this
      if (if null is r and null is i then (i = n
      r = n = t
      ) else null is i and ((if "string" is typeof n then (i = r
      r = t
      ) else (i = r
      r = n
      n = t
      ))))
      i is not 1
        i = ot
      else return this  unless i
      1 is o and (s = i
      i = (e) ->
        b().off(e)
        s.apply(this, arguments_)

      i.guid = s.guid or (s.guid = b.guid++)
      )
      @each(->
        b.event.add this, e, i, r, n
      )

    one: (e, t, n, r) ->
      @on e, t, n, r, 1

    off: (e, n, r) ->
      i = undefined
      o = undefined
      if e and e.preventDefault and e.handleObj
        return i = e.handleObj
        b(e.delegateTarget).off((if i.namespace then i.origType + "." + i.namespace else i.origType), i.selector, i.handler)
        this
      if "object" is typeof e
        for o of e
          @off o, n, e[o]
        return this
      (n is not 1 or "function" is typeof n) and (r = n
      n = t
      )
      r is not 1 and (r = ot)
      @each(->
        b.event.remove this, e, r, n
      )

    bind: (e, t, n) ->
      @on e, null, t, n

    unbind: (e, t) ->
      @off e, null, t

    delegate: (e, t, n, r) ->
      @on t, e, n, r

    undelegate: (e, t, n) ->
      (if 1 is arguments_.length then @off(e, "**") else @off(t, e or "**", n))

    trigger: (e, t) ->
      @each ->
        b.event.trigger e, t, this


    triggerHandler: (e, n) ->
      r = this[0]
      (if r then b.event.trigger(e, n, r, not 0) else t)
  )
  (e, t) ->
    rt = (e) ->
      Y.test e + ""
    it = ->
      e = undefined
      t = []
      e = (n, r) ->
        t.push(n += " ") > i.cacheLength and delete e[t.shift()]

        e[n] = r
    ot = (e) ->
      e[x] = not 0
      e
    at = (e) ->
      t = p.createElement("div")
      try
        return e(t)
      catch n
        return not 1
      finally
        t = null
    st = (e, t, n, r) ->
      i = undefined
      o = undefined
      a = undefined
      s = undefined
      u = undefined
      l = undefined
      f = undefined
      g = undefined
      m = undefined
      v = undefined
      return n  if ((if t then t.ownerDocument or t else w)) isnt p and c(t)
      t = t or p
      n = n or []
      not e or "string" isnt typeof e

      return []  if 1 isnt (s = t.nodeType) and 9 isnt s
      if not d and not r
        if i = J.exec(e)
          if a = i[1]
            if 9 is s
              return n  if o = t.getElementById(a)
              not o or not o.parentNode

              if o.id is a
                return n.push(o)
                n
            else if t.ownerDocument and (o = t.ownerDocument.getElementById(a)) and y(t, o) and o.id is a
              return n.push(o)
              n
          else
            if i[2]
              return H.apply(n, q.call(t.getElementsByTagName(e), 0))
              n
            if (a = i[3]) and T.getByClassName and t.getElementsByClassName
              return H.apply(n, q.call(t.getElementsByClassName(a), 0))
              n
        if T.qsa and not h.test(e)
          if f = not 0
          g = x
          m = t
          v = 9 is s and e
          1 is s and "object" isnt t.nodeName.toLowerCase()
            l = ft(e)
            (if (f = t.getAttribute("id")) then g = f.replace(K, "\\$&") else t.setAttribute("id", g))
            g = "[id='" + g + "'] "
            u = l.length

            l[u] = g + dt(l[u])  while u--
            m = V.test(e) and t.parentNode or t
            v = l.join(",")
          if v
            try
              return H.apply(n, q.call(m.querySelectorAll(v), 0))
              n
            finally
              f or t.removeAttribute("id")
      wt e.replace(W, "$1"), t, n, r
    ut = (e, t) ->
      n = t and e
      r = n and (~t.sourceIndex or j) - (~e.sourceIndex or j)
      return r  if r
      return -1  if n is t  while n = n.nextSibling  if n
      (if e then 1 else -1)
    lt = (e) ->
      (t) ->
        n = t.nodeName.toLowerCase()
        "input" is n and t.type is e
    ct = (e) ->
      (t) ->
        n = t.nodeName.toLowerCase()
        ("input" is n or "button" is n) and t.type is e
    pt = (e) ->
      ot (t) ->
        t = +t
        ot((n, r) ->
          i = undefined
          o = e([], n.length, t)
          a = o.length
          n[i = o[a]] and (n[i] = not (r[i] = n[i]))  while a--
        )

    ft = (e, t) ->
      n = undefined
      r = undefined
      o = undefined
      a = undefined
      s = undefined
      u = undefined
      l = undefined
      c = E[e + " "]
      return (if t then 0 else c.slice(0))  if c
      s = e
      u = []
      l = i.preFilter

      while s
        (not n or (r = $.exec(s))) and (r and (s = s.slice(r[0].length) or s)
        u.push(o = [])
        )
        n = not 1
        (r = I.exec(s)) and (n = r.shift()
        o.push(
          value: n
          type: r[0].replace(W, " ")
        )
        s = s.slice(n.length)
        )

        for a of i.filter
          not (r = U[a].exec(s)) or l[a] and not (r = l[a](r)) or (n = r.shift()
          o.push(
            value: n
            type: a
            matches: r
          )
          s = s.slice(n.length)
          )
        break  unless n
      (if t then s.length else (if s then st.error(e) else E(e, u).slice(0)))
    dt = (e) ->
      t = 0
      n = e.length
      r = ""
      while n > t
        r += e[t].value
        t++
      r
    ht = (e, t, n) ->
      i = t.dir
      o = n and "parentNode" is i
      a = C++
      (if t.first then (t, n, r) ->
        return e(t, n, r)  if 1 is t.nodeType or o  while t = t[i]
       else (t, n, s) ->
        u = undefined
        l = undefined
        c = undefined
        p = N + " " + a
        if s
          return not 0  if (1 is t.nodeType or o) and e(t, n, s)  while t = t[i]
        else
          while t = t[i]
            if 1 is t.nodeType or o
              if c = t[x] or (t[x] = {})
              (l = c[i]) and l[0] is p
                return u is not 0  if (u = l[1]) is not 0 or u is r
              else return not 0  if l = c[i] = [p]
              l[1] = e(t, n, s) or r
              l[1] is not 0
      )
    gt = (e) ->
      (if e.length > 1 then (t, n, r) ->
        i = e.length
        return not 1  unless e[i](t, n, r)  while i--
        not 0
       else e[0])
    mt = (e, t, n, r, i) ->
      o = undefined
      a = []
      s = 0
      u = e.length
      l = null isnt t
      while u > s
        (o = e[s]) and (not n or n(o, r, i)) and (a.push(o)
        l and t.push(s)
        )
        s++
      a
    yt = (e, t, n, r, i, o) ->
      r and not r[x] and (r = yt(r))
      i and not i[x] and (i = yt(i, o))
      ot((o, a, s, u) ->
        l = undefined
        c = undefined
        p = undefined
        f = []
        d = []
        h = a.length
        g = o or xt(t or "*", (if s.nodeType then [s] else s), [])
        m = (if not e or not o and t then g else mt(g, f, e, s, u))
        y = (if n then (if i or ((if o then e else h or r)) then [] else a) else m)
        if n and n(m, y, s, u)
        r
          l = mt(y, d)
          r(l, [], s, u)
          c = l.length

          (p = l[c]) and (y[d[c]] = not (m[d[c]] = p))  while c--
        if o
          if i or e
            if i
              l = []
              c = y.length

              (p = y[c]) and l.push(m[c] = p)  while c--
              i null, y = [], l, u
            c = y.length
            (p = y[c]) and (l = (if i then M.call(o, p) else f[c])) > -1 and (o[l] = not (a[l] = p))  while c--
        else
          y = mt((if y is a then y.splice(h, y.length) else y))
          (if i then i(null, a, y, u) else H.apply(a, y))
      )
    vt = (e) ->
      t = undefined
      n = undefined
      r = undefined
      o = e.length
      a = i.relative[e[0].type]
      s = a or i.relative[" "]
      u = (if a then 1 else 0)
      c = ht((e) ->
        e is t
      , s, not 0)
      p = ht((e) ->
        M.call(t, e) > -1
      , s, not 0)
      f = [(e, n, r) ->
        not a and (r or n isnt l) or ((if (t = n).nodeType then c(e, n, r) else p(e, n, r)))
      ]
      while o > u
        unless n = i.relative[e[u].type]
          if n = i.filter[e[u].type].apply(null, e[u].matches)
          n[x]
            r = ++u
            while o > r
              break  if i.relative[e[r].type]
              r++
            return yt(u > 1 and gt(f), u > 1 and dt(e.slice(0, u - 1)).replace(W, "$1"), n, r > u and vt(e.slice(u, r)), o > r and vt(e = e.slice(r)), o > r and dt(e))
          f.push n
        u++
      gt f
    bt = (e, t) ->
      n = 0
      o = t.length > 0
      a = e.length > 0
      s = (s, u, c, f, d) ->
        h = undefined
        g = undefined
        m = undefined
        y = []
        v = 0
        b = "0"
        x = s and []
        w = null isnt d
        T = l
        C = s or a and i.find.TAG("*", d and u.parentNode or u)
        k = N += (if null is T then 1 else Math.random() or .1)
        w and (l = u isnt p and u
        r = n
        )
        while null isnt (h = C[b])
          if a and h
            g = 0
            while m = e[g++]
              if m(h, u, c)
                f.push h
                break
            w and (N = k
            r = ++n
            )
          o and ((h = not m and h) and v--
          s and x.push(h)
          )
          b++
        if v += b
        o and b isnt v
          g = 0
          m x, y, u, c  while m = t[g++]
          if s
            x[b] or y[b] or (y[b] = L.call(f))  while b--  if v > 0
            y = mt(y)
          H.apply(f, y)
          w and not s and y.length > 0 and v + t.length > 1 and st.uniqueSort(f)
        w and (N = k
        l = T
        )
        x

      (if o then ot(s) else s)
    xt = (e, t, n) ->
      r = 0
      i = t.length
      while i > r
        st e, t[r], n
        r++
      n
    wt = (e, t, n, r) ->
      o = undefined
      a = undefined
      u = undefined
      l = undefined
      c = undefined
      p = ft(e)
      if not r and 1 is p.length
        if a = p[0] = p[0].slice(0)
        a.length > 2 and "ID" is (u = a[0]).type and 9 is t.nodeType and not d and i.relative[a[1].type]
          return n  if t = i.find.ID(u.matches[0].replace(et, tt), t)[0]
          not t

          e = e.slice(a.shift().value.length)
        o = (if U.needsContext.test(e) then 0 else a.length)
        while o--
          break  if u = a[o]
          i.relative[l = u.type]

          if (c = i.find[l]) and (r = c(u.matches[0].replace(et, tt), V.test(a[0].type) and t.parentNode or t))
            if a.splice(o, 1)
            e = r.length and dt(a)
            not e
              return H.apply(n, q.call(r, 0))
              n
            break
      s(e, p)(r, t, d, n, V.test(e))
      n
    Tt = ->
    n = undefined
    r = undefined
    i = undefined
    o = undefined
    a = undefined
    s = undefined
    u = undefined
    l = undefined
    c = undefined
    p = undefined
    f = undefined
    d = undefined
    h = undefined
    g = undefined
    m = undefined
    y = undefined
    v = undefined
    x = "sizzle" + -new Date
    w = e.document
    T = {}
    N = 0
    C = 0
    k = it()
    E = it()
    S = it()
    A = typeof t
    j = 1 << 31
    D = []
    L = D.pop
    H = D.push
    q = D.slice
    M = D.indexOf or (e) ->
      t = 0
      n = @length
      while n > t
        return t  if this[t] is e
        t++
      -1

    _ = "[\\x20\\t\\r\\n\\f]"
    F = "(?:\\\\.|[\\w-]|[^\\x00-\\xa0])+"
    O = F.replace("w", "w#")
    B = "([*^$|!~]?=)"
    P = "\\[" + _ + "*(" + F + ")" + _ + "*(?:" + B + _ + "*(?:(['\"])((?:\\\\.|[^\\\\])*?)\\3|(" + O + ")|)|)" + _ + "*\\]"
    R = ":(" + F + ")(?:\\(((['\"])((?:\\\\.|[^\\\\])*?)\\3|((?:\\\\.|[^\\\\()[\\]]|" + P.replace(3, 8) + ")*)|.*)\\)|)"
    W = RegExp("^" + _ + "+|((?:^|[^\\\\])(?:\\\\.)*)" + _ + "+$", "g")
    $ = RegExp("^" + _ + "*," + _ + "*")
    I = RegExp("^" + _ + "*([\\x20\\t\\r\\n\\f>+~])" + _ + "*")
    z = RegExp(R)
    X = RegExp("^" + O + "$")
    U =
      ID: RegExp("^#(" + F + ")")
      CLASS: RegExp("^\\.(" + F + ")")
      NAME: RegExp("^\\[name=['\"]?(" + F + ")['\"]?\\]")
      TAG: RegExp("^(" + F.replace("w", "w*") + ")")
      ATTR: RegExp("^" + P)
      PSEUDO: RegExp("^" + R)
      CHILD: RegExp("^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\(" + _ + "*(even|odd|(([+-]|)(\\d*)n|)" + _ + "*(?:([+-]|)" + _ + "*(\\d+)|))" + _ + "*\\)|)", "i")
      needsContext: RegExp("^" + _ + "*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\(" + _ + "*((?:-\\d)?\\d*)" + _ + "*\\)|)(?=[^-]|$)", "i")

    V = /[\x20\t\r\n\f]*[+~]/
    Y = /^[^{]+\{\s*\[native code/
    J = /^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/
    G = /^(?:input|select|textarea|button)$/i
    Q = /^h\d$/i
    K = /'|\\/g
    Z = /\=[\x20\t\r\n\f]*([^'"\]]*)[\x20\t\r\n\f]*\]/g
    et = /\\([\da-fA-F]{1,6}[\x20\t\r\n\f]?|.)/g
    tt = (e, t) ->
      n = "0x" + t - 65536
      (if n isnt n then t else (if 0 > n then String.fromCharCode(n + 65536) else String.fromCharCode(55296 | n >> 10, 56320 | 1023 & n)))

    try
      q.call(w.documentElement.childNodes, 0)[0].nodeType
    catch nt
      q = (e) ->
        t = undefined
        n = []
        n.push t  while t = this[e++]
        n
    a = st.isXML = (e) ->
      t = e and (e.ownerDocument or e).documentElement
      (if t then "HTML" isnt t.nodeName else not 1)

    c = st.setDocument = (e) ->
      n = (if e then e.ownerDocument or e else w)
      (if n isnt p and 9 is n.nodeType and n.documentElement then (p = n
      f = n.documentElement
      d = a(n)
      T.tagNameNoComments = at((e) ->
        e.appendChild(n.createComment(""))
        not e.getElementsByTagName("*").length
      )
      T.attributes = at((e) ->
        e.innerHTML = "<select></select>"
        t = typeof e.lastChild.getAttribute("multiple")
        "boolean" isnt t and "string" isnt t
      )
      T.getByClassName = at((e) ->
        e.innerHTML = "<div class='hidden e'></div><div class='hidden'></div>"
        (if e.getElementsByClassName and e.getElementsByClassName("e").length then (e.lastChild.className = "e"
        2 is e.getElementsByClassName("e").length
        ) else not 1)
      )
      T.getByName = at((e) ->
        e.id = x + 0
        e.innerHTML = "<a name='" + x + "'></a><div name='" + x + "'></div>"
        f.insertBefore(e, f.firstChild)

        t = n.getElementsByName and n.getElementsByName(x).length is 2 + n.getElementsByName(x + 0).length
        T.getIdNotName = not n.getElementById(x)
        f.removeChild(e)
        t
      )
      i.attrHandle = (if at((e) ->
        e.innerHTML = "<a href='#'></a>"
        e.firstChild and typeof e.firstChild.getAttribute isnt A and "#" is e.firstChild.getAttribute("href")
      ) then {} else
        href: (e) ->
          e.getAttribute "href", 2

        type: (e) ->
          e.getAttribute "type"
      )
      (if T.getIdNotName then (i.find.ID = (e, t) ->
        if typeof t.getElementById isnt A and not d
          n = t.getElementById(e)
          (if n and n.parentNode then [n] else [])

      i.filter.ID = (e) ->
        t = e.replace(et, tt)
        (e) ->
          e.getAttribute("id") is t

      ) else (i.find.ID = (e, n) ->
        if typeof n.getElementById isnt A and not d
          r = n.getElementById(e)
          (if r then (if r.id is e or typeof r.getAttributeNode isnt A and r.getAttributeNode("id").value is e then [r] else t) else [])

      i.filter.ID = (e) ->
        t = e.replace(et, tt)
        (e) ->
          n = typeof e.getAttributeNode isnt A and e.getAttributeNode("id")
          n and n.value is t

      ))
      i.find.TAG = (if T.tagNameNoComments then (e, n) ->
        (if typeof n.getElementsByTagName isnt A then n.getElementsByTagName(e) else t)
       else (e, t) ->
        n = undefined
        r = []
        i = 0
        o = t.getElementsByTagName(e)
        if "*" is e
          1 is n.nodeType and r.push(n)  while n = o[i++]
          return r
        o
      )
      i.find.NAME = T.getByName and (e, n) ->
        (if typeof n.getElementsByName isnt A then n.getElementsByName(name) else t)

      i.find.CLASS = T.getByClassName and (e, n) ->
        (if typeof n.getElementsByClassName is A or d then t else n.getElementsByClassName(e))

      g = []
      h = [":focus"]
      (T.qsa = rt(n.querySelectorAll)) and (at((e) ->
        e.innerHTML = "<select><option selected=''></option></select>"
        e.querySelectorAll("[selected]").length or h.push("\\[" + _ + "*(?:checked|disabled|ismap|multiple|readonly|selected|value)")
        e.querySelectorAll(":checked").length or h.push(":checked")
      )
      at((e) ->
        e.innerHTML = "<input type='hidden' i=''/>"
        e.querySelectorAll("[i^='']").length and h.push("[*^$]=" + _ + "*(?:\"\"|'')")
        e.querySelectorAll(":enabled").length or h.push(":enabled", ":disabled")
        e.querySelectorAll("*,:x")
        h.push(",.*:")
      )
      )
      (T.matchesSelector = rt(m = f.matchesSelector or f.mozMatchesSelector or f.webkitMatchesSelector or f.oMatchesSelector or f.msMatchesSelector)) and at((e) ->
        T.disconnectedMatch = m.call(e, "div")
        m.call(e, "[s!='']:x")
        g.push("!=", R)
      )
      h = RegExp(h.join("|"))
      g = RegExp(g.join("|"))
      y = (if rt(f.contains) or f.compareDocumentPosition then (e, t) ->
        n = (if 9 is e.nodeType then e.documentElement else e)
        r = t and t.parentNode
        e is r or not (not r or 1 isnt r.nodeType or not ((if n.contains then n.contains(r) else e.compareDocumentPosition and 16 & e.compareDocumentPosition(r))))
       else (e, t) ->
        return not 0  if t is e  while t = t.parentNode  if t
        not 1
      )
      v = (if f.compareDocumentPosition then (e, t) ->
        r = undefined
        (if e is t then (u = not 0
        0
        ) else (if (r = t.compareDocumentPosition and e.compareDocumentPosition and e.compareDocumentPosition(t)) then (if 1 & r or e.parentNode and 11 is e.parentNode.nodeType then (if e is n or y(w, e) then -1 else (if t is n or y(w, t) then 1 else 0)) else (if 4 & r then -1 else 1)) else (if e.compareDocumentPosition then -1 else 1)))
       else (e, t) ->
        r = undefined
        i = 0
        o = e.parentNode
        a = t.parentNode
        s = [e]
        l = [t]
        if e is t
          return u = not 0
          0
        return (if e is n then -1 else (if t is n then 1 else (if o then -1 else (if a then 1 else 0))))  if not o or not a
        return ut(e, t)  if o is a
        r = e
        s.unshift r  while r = r.parentNode
        r = t
        l.unshift r  while r = r.parentNode
        i++  while s[i] is l[i]
        (if i then ut(s[i], l[i]) else (if s[i] is w then -1 else (if l[i] is w then 1 else 0)))
      )
      u = not 1
      [0, 0].sort(v)
      T.detectDuplicates = u
      p
      ) else p)

    st.matches = (e, t) ->
      st e, null, null, t

    st.matchesSelector = (e, t) ->
      if (e.ownerDocument or e) isnt p and c(e)
      t = t.replace(Z, "='$1']")
      not (not T.matchesSelector or d or g and g.test(t) or h.test(t))
        try
          n = m.call(e, t)
          return n  if n or T.disconnectedMatch or e.document and 11 isnt e.document.nodeType
      st(t, p, null, [e]).length > 0

    st.contains = (e, t) ->
      (e.ownerDocument or e) isnt p and c(e)
      y(e, t)

    st.attr = (e, t) ->
      n = undefined
      (e.ownerDocument or e) isnt p and c(e)
      d or (t = t.toLowerCase())
      (if (n = i.attrHandle[t]) then n(e) else (if d or T.attributes then e.getAttribute(t) else (if ((n = e.getAttributeNode(t)) or e.getAttribute(t)) and e[t] is not 0 then t else (if n and n.specified then n.value else null))))

    st.error = (e) ->
      throw Error("Syntax error, unrecognized expression: " + e)

    st.uniqueSort = (e) ->
      t = undefined
      n = []
      r = 1
      i = 0
      if u = not T.detectDuplicates
      e.sort(v)
      u
        while t = e[r]
          t is e[r - 1] and (i = n.push(r))
          r++
        e.splice n[i], 1  while i--
      e


    o = st.getText = (e) ->
      t = undefined
      n = ""
      r = 0
      i = e.nodeType
      if i
        if 1 is i or 9 is i or 11 is i
          return e.textContent  if "string" is typeof e.textContent
          e = e.firstChild
          while e
            n += o(e)
            e = e.nextSibling
        else return e.nodeValue  if 3 is i or 4 is i
      else
        while t = e[r]
          n += o(t)
          r++
      n

    i = st.selectors =
      cacheLength: 50
      createPseudo: ot
      match: U
      find: {}
      relative:
        ">":
          dir: "parentNode"
          first: not 0

        " ":
          dir: "parentNode"

        "+":
          dir: "previousSibling"
          first: not 0

        "~":
          dir: "previousSibling"

      preFilter:
        ATTR: (e) ->
          e[1] = e[1].replace(et, tt)
          e[3] = (e[4] or e[5] or "").replace(et, tt)
          "~=" is e[2] and (e[3] = " " + e[3] + " ")
          e.slice(0, 4)

        CHILD: (e) ->
          e[1] = e[1].toLowerCase()
          (if "nth" is e[1].slice(0, 3) then (e[3] or st.error(e[0])
          e[4] = +((if e[4] then e[5] + (e[6] or 1) else 2 * ("even" is e[3] or "odd" is e[3])))
          e[5] = +(e[7] + e[8] or "odd" is e[3])
          ) else e[3] and st.error(e[0]))
          e

        PSEUDO: (e) ->
          t = undefined
          n = not e[5] and e[2]
          (if U.CHILD.test(e[0]) then null else ((if e[4] then e[2] = e[4] else n and z.test(n) and (t = ft(n, not 0)) and (t = n.indexOf(")", n.length - t) - n.length) and (e[0] = e[0].slice(0, t)
          e[2] = n.slice(0, t)
          ))
          e.slice(0, 3)
          ))

      filter:
        TAG: (e) ->
          (if "*" is e then ->
            not 0
           else (e = e.replace(et, tt).toLowerCase()
          (t) ->
            t.nodeName and t.nodeName.toLowerCase() is e

          ))

        CLASS: (e) ->
          t = k[e + " "]
          t or (t = RegExp("(^|" + _ + ")" + e + "(" + _ + "|$)")) and k(e, (e) ->
            t.test e.className or typeof e.getAttribute isnt A and e.getAttribute("class") or ""
          )

        ATTR: (e, t, n) ->
          (r) ->
            i = st.attr(r, e)
            (if null is i then "!=" is t else (if t then (i += ""
            (if "=" is t then i is n else (if "!=" is t then i isnt n else (if "^=" is t then n and 0 is i.indexOf(n) else (if "*=" is t then n and i.indexOf(n) > -1 else (if "$=" is t then n and i.slice(-n.length) is n else (if "~=" is t then (" " + i + " ").indexOf(n) > -1 else (if "|=" is t then i is n or i.slice(0, n.length + 1) is n + "-" else not 1)))))))
            ) else not 0))

        CHILD: (e, t, n, r, i) ->
          o = "nth" isnt e.slice(0, 3)
          a = "last" isnt e.slice(-4)
          s = "of-type" is t
          (if 1 is r and 0 is i then (e) ->
            !!e.parentNode
           else (t, n, u) ->
            l = undefined
            c = undefined
            p = undefined
            f = undefined
            d = undefined
            h = undefined
            g = (if o isnt a then "nextSibling" else "previousSibling")
            m = t.parentNode
            y = s and t.nodeName.toLowerCase()
            v = not u and not s
            if m
              if o
                while g
                  p = t
                  return not 1  if (if s then p.nodeName.toLowerCase() is y else 1 is p.nodeType)  while p = p[g]
                  h = g = "only" is e and not h and "nextSibling"
                return not 0
              if h = [(if a then m.firstChild else m.lastChild)]
              a and v
                c = m[x] or (m[x] = {})
                l = c[e] or []
                d = l[0] is N and l[1]
                f = l[0] is N and l[2]
                p = d and m.childNodes[d]

                while p = ++d and p and p[g] or (f = d = 0) or h.pop()
                  if 1 is p.nodeType and ++f and p is t
                    c[e] = [N, d, f]
                    break
              else if v and (l = (t[x] or (t[x] = {}))[e]) and l[0] is N
                f = l[1]
              else
                while p = ++d and p and p[g] or (f = d = 0) or h.pop()
                  break  if ((if s then p.nodeName.toLowerCase() is y else 1 is p.nodeType)) and ++f and (v and ((p[x] or (p[x] = {}))[e] = [N, f])
                  p is t
                  )
              f -= i
              f is r or 0 is f % r and f / r >= 0
          )

        PSEUDO: (e, t) ->
          n = undefined
          r = i.pseudos[e] or i.setFilters[e.toLowerCase()] or st.error("unsupported pseudo: " + e)
          (if r[x] then r(t) else (if r.length > 1 then (n = [e, e, "", t]
          (if i.setFilters.hasOwnProperty(e.toLowerCase()) then ot((e, n) ->
            i = undefined
            o = r(e, t)
            a = o.length
            while a--
              i = M.call(e, o[a])
              e[i] = not (n[i] = o[a])
          ) else (e) ->
            r e, 0, n
          )
          ) else r))

      pseudos:
        not: ot((e) ->
          t = []
          n = []
          r = s(e.replace(W, "$1"))
          (if r[x] then ot((e, t, n, i) ->
            o = undefined
            a = r(e, null, i, [])
            s = e.length
            (o = a[s]) and (e[s] = not (t[s] = o))  while s--
          ) else (e, i, o) ->
            t[0] = e
            r(t, null, o, n)
            not n.pop()
          )
        )
        has: ot((e) ->
          (t) ->
            st(e, t).length > 0
        )
        contains: ot((e) ->
          (t) ->
            (t.textContent or t.innerText or o(t)).indexOf(e) > -1
        )
        lang: ot((e) ->
          X.test(e or "") or st.error("unsupported lang: " + e)
          e = e.replace(et, tt).toLowerCase()
          (t) ->
            n = undefined
            loop
              if n = (if d then t.getAttribute("xml:lang") or t.getAttribute("lang") else t.lang)
                return n = n.toLowerCase()
                n is e or 0 is n.indexOf(e + "-")
              break unless (t = t.parentNode) and 1 is t.nodeType
            not 1
        )
        target: (t) ->
          n = e.location and e.location.hash
          n and n.slice(1) is t.id

        root: (e) ->
          e is f

        focus: (e) ->
          e is p.activeElement and (not p.hasFocus or p.hasFocus()) and !!(e.type or e.href or ~e.tabIndex)

        enabled: (e) ->
          e.disabled is not 1

        disabled: (e) ->
          e.disabled is not 0

        checked: (e) ->
          t = e.nodeName.toLowerCase()
          "input" is t and !!e.checked or "option" is t and !!e.selected

        selected: (e) ->
          e.parentNode and e.parentNode.selectedIndex
          e.selected is not 0

        empty: (e) ->
          e = e.firstChild
          while e
            return not 1  if e.nodeName > "@" or 3 is e.nodeType or 4 is e.nodeType
            e = e.nextSibling
          not 0

        parent: (e) ->
          not i.pseudos.empty(e)

        header: (e) ->
          Q.test e.nodeName

        input: (e) ->
          G.test e.nodeName

        button: (e) ->
          t = e.nodeName.toLowerCase()
          "input" is t and "button" is e.type or "button" is t

        text: (e) ->
          t = undefined
          "input" is e.nodeName.toLowerCase() and "text" is e.type and (null is (t = e.getAttribute("type")) or t.toLowerCase() is e.type)

        first: pt(->
          [0]
        )
        last: pt((e, t) ->
          [t - 1]
        )
        eq: pt((e, t, n) ->
          [(if 0 > n then n + t else n)]
        )
        even: pt((e, t) ->
          n = 0
          while t > n
            e.push n
            n += 2
          e
        )
        odd: pt((e, t) ->
          n = 1
          while t > n
            e.push n
            n += 2
          e
        )
        lt: pt((e, t, n) ->
          r = (if 0 > n then n + t else n)
          while --r >= 0
            e.push r
          e
        )
        gt: pt((e, t, n) ->
          r = (if 0 > n then n + t else n)
          while t > ++r
            e.push r
          e
        )


    for n of
      radio: not 0
      checkbox: not 0
      file: not 0
      password: not 0
      image: not 0
      i.pseudos[n] = lt(n)
    for n of
      submit: not 0
      reset: not 0
      i.pseudos[n] = ct(n)
    s = st.compile = (e, t) ->
      n = undefined
      r = []
      i = []
      o = S[e + " "]
      unless o
        t or (t = ft(e))
        n = t.length

        while n--
          o = vt(t[n])
          (if o[x] then r.push(o) else i.push(o))
        o = S(e, bt(i, r))
      o

    i.pseudos.nth = i.pseudos.eq
    i.filters = Tt:: = i.pseudos
    i.setFilters = new Tt
    c()
    st.attr = b.attr
    b.find = st
    b.expr = st.selectors
    b.expr[":"] = b.expr.pseudos
    b.unique = st.uniqueSort
    b.text = st.getText
    b.isXMLDoc = st.isXML
    b.contains = st.contains
  (e)

  at = /Until$/
  st = /^(?:parents|prev(?:Until|All))/
  ut = /^.[^:#\[\.,]*$/
  lt = b.expr.match.needsContext
  ct =
    children: not 0
    contents: not 0
    next: not 0
    prev: not 0

  b.fn.extend(
    find: (e) ->
      t = undefined
      n = undefined
      r = undefined
      i = @length
      unless "string" is typeof e
        return r = this
        @pushStack(b(e).filter(->
          t = 0
          while i > t
            return not 0  if b.contains(r[t], this)
            t++
        ))
      n = []
      t = 0

      while i > t
        b.find e, this[t], n
        t++
      n = @pushStack((if i > 1 then b.unique(n) else n))
      n.selector = ((if @selector then @selector + " " else "")) + e
      n

    has: (e) ->
      t = undefined
      n = b(e, this)
      r = n.length
      @filter ->
        t = 0
        while r > t
          return not 0  if b.contains(this, n[t])
          t++


    not: (e) ->
      @pushStack ft(this, e, not 1)

    filter: (e) ->
      @pushStack ft(this, e, not 0)

    is: (e) ->
      !!e and ((if "string" is typeof e then (if lt.test(e) then b(e, @context).index(this[0]) >= 0 else b.filter(e, this).length > 0) else @filter(e).length > 0))

    closest: (e, t) ->
      n = undefined
      r = 0
      i = @length
      o = []
      a = (if lt.test(e) or "string" isnt typeof e then b(e, t or @context) else 0)
      while i > r
        n = this[r]
        while n and n.ownerDocument and n isnt t and 11 isnt n.nodeType
          if (if a then a.index(n) > -1 else b.find.matchesSelector(n, e))
            o.push n
            break
          n = n.parentNode
        r++
      @pushStack (if o.length > 1 then b.unique(o) else o)

    index: (e) ->
      (if e then (if "string" is typeof e then b.inArray(this[0], b(e)) else b.inArray((if e.jquery then e[0] else e), this)) else (if this[0] and this[0].parentNode then @first().prevAll().length else -1))

    add: (e, t) ->
      n = (if "string" is typeof e then b(e, t) else b.makeArray((if e and e.nodeType then [e] else e)))
      r = b.merge(@get(), n)
      @pushStack b.unique(r)

    addBack: (e) ->
      @add (if null is e then @prevObject else @prevObject.filter(e))
  )
  b.fn.andSelf = b.fn.addBack

  b.each(
    parent: (e) ->
      t = e.parentNode
      (if t and 11 isnt t.nodeType then t else null)

    parents: (e) ->
      b.dir e, "parentNode"

    parentsUntil: (e, t, n) ->
      b.dir e, "parentNode", n

    next: (e) ->
      pt e, "nextSibling"

    prev: (e) ->
      pt e, "previousSibling"

    nextAll: (e) ->
      b.dir e, "nextSibling"

    prevAll: (e) ->
      b.dir e, "previousSibling"

    nextUntil: (e, t, n) ->
      b.dir e, "nextSibling", n

    prevUntil: (e, t, n) ->
      b.dir e, "previousSibling", n

    siblings: (e) ->
      b.sibling (e.parentNode or {}).firstChild, e

    children: (e) ->
      b.sibling e.firstChild

    contents: (e) ->
      (if b.nodeName(e, "iframe") then e.contentDocument or e.contentWindow.document else b.merge([], e.childNodes))
  , (e, t) ->
    b.fn[e] = (n, r) ->
      i = b.map(this, t, n)
      at.test(e) or (r = n)
      r and "string" is typeof r and (i = b.filter(r, i))
      i = (if @length > 1 and not ct[e] then b.unique(i) else i)
      @length > 1 and st.test(e) and (i = i.reverse())
      @pushStack(i)
  )
  b.extend(
    filter: (e, t, n) ->
      n and (e = ":not(" + e + ")")
      (if 1 is t.length then (if b.find.matchesSelector(t[0], e) then [t[0]] else []) else b.find.matches(e, t))

    dir: (e, n, r) ->
      i = []
      o = e[n]
      while o and 9 isnt o.nodeType and (r is t or 1 isnt o.nodeType or not b(o).is(r))
        1 is o.nodeType and i.push(o)
        o = o[n]
      i

    sibling: (e, t) ->
      n = []
      while e
        1 is e.nodeType and e isnt t and n.push(e)
        e = e.nextSibling
      n
  )

  ht = "abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video"
  gt = RegExp(" jQuery\\d+=\"(?:null|\\d+)\"", "g")
  mt = RegExp("<(?:" + ht + ")[\\s/>]", "i")
  yt = /^\s+/
  vt = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/g
  bt = /<([\w:]+)/
  xt = /<tbody/i
  wt = /<|&#?\w+;/
  Tt = /<(?:script|style|link)/i
  Nt = /^(?:checkbox|radio)$/i
  Ct = /checked\s*(?:[^=]|=\s*.checked.)/i
  kt = /^$|\/(?:java|ecma)script/i
  Et = /^true\/(.*)/
  St = /^\s*<!(?:\[CDATA\[|--)|(?:\]\]|--)>\s*$/g
  At =
    option: [1, "<select multiple='multiple'>", "</select>"]
    legend: [1, "<fieldset>", "</fieldset>"]
    area: [1, "<map>", "</map>"]
    param: [1, "<object>", "</object>"]
    thead: [1, "<table>", "</table>"]
    tr: [2, "<table><tbody>", "</tbody></table>"]
    col: [2, "<table><tbody></tbody><colgroup>", "</colgroup></table>"]
    td: [3, "<table><tbody><tr>", "</tr></tbody></table>"]
    _default: (if b.support.htmlSerialize then [0, "", ""] else [1, "X<div>", "</div>"])

  jt = dt(o)
  Dt = jt.appendChild(o.createElement("div"))
  At.optgroup = At.option
  At.tbody = At.tfoot = At.colgroup = At.caption = At.thead
  At.th = At.td
  b.fn.extend(
    text: (e) ->
      b.access this, ((e) ->
        (if e is t then b.text(this) else @empty().append((this[0] and this[0].ownerDocument or o).createTextNode(e)))
      ), null, e, arguments_.length

    wrapAll: (e) ->
      if b.isFunction(e)
        return @each((t) ->
          b(this).wrapAll e.call(this, t)
        )
      if this[0]
        t = b(e, this[0].ownerDocument).eq(0).clone(not 0)
        this[0].parentNode and t.insertBefore(this[0])
        t.map(->
          e = this
          e = e.firstChild  while e.firstChild and 1 is e.firstChild.nodeType
          e
        ).append(this)
      this

    wrapInner: (e) ->
      (if b.isFunction(e) then @each((t) ->
        b(this).wrapInner e.call(this, t)
      ) else @each(->
        t = b(this)
        n = t.contents()
        (if n.length then n.wrapAll(e) else t.append(e))
      ))

    wrap: (e) ->
      t = b.isFunction(e)
      @each (n) ->
        b(this).wrapAll (if t then e.call(this, n) else e)


    unwrap: ->
      @parent().each(->
        b.nodeName(this, "body") or b(this).replaceWith(@childNodes)
      ).end()

    append: ->
      @domManip arguments_, not 0, (e) ->
        (1 is @nodeType or 11 is @nodeType or 9 is @nodeType) and @appendChild(e)


    prepend: ->
      @domManip arguments_, not 0, (e) ->
        (1 is @nodeType or 11 is @nodeType or 9 is @nodeType) and @insertBefore(e, @firstChild)


    before: ->
      @domManip arguments_, not 1, (e) ->
        @parentNode and @parentNode.insertBefore(e, this)


    after: ->
      @domManip arguments_, not 1, (e) ->
        @parentNode and @parentNode.insertBefore(e, @nextSibling)


    remove: (e, t) ->
      n = undefined
      r = 0
      while null isnt (n = this[r])
        (not e or b.filter(e, [n]).length > 0) and (t or 1 isnt n.nodeType or b.cleanData(Ot(n))
        n.parentNode and (t and b.contains(n.ownerDocument, n) and Mt(Ot(n, "script"))
        n.parentNode.removeChild(n)
        )
        )
        r++
      this

    empty: ->
      e = undefined
      t = 0
      while null isnt (e = this[t])
        1 is e.nodeType and b.cleanData(Ot(e, not 1))
        e.removeChild e.firstChild  while e.firstChild
        e.options and b.nodeName(e, "select") and (e.options.length = 0)
        t++
      this

    clone: (e, t) ->
      e = (if null is e then not 1 else e)
      t = (if null is t then e else t)
      @map(->
        b.clone this, e, t
      )

    html: (e) ->
      b.access this, ((e) ->
        n = this[0] or {}
        r = 0
        i = @length
        return (if 1 is n.nodeType then n.innerHTML.replace(gt, "") else t)  if e is t
        unless "string" isnt typeof e or Tt.test(e) or not b.support.htmlSerialize and mt.test(e) or not b.support.leadingWhitespace and yt.test(e) or At[(bt.exec(e) or ["", ""])[1].toLowerCase()]
          e = e.replace(vt, "<$1></$2>")
          try
            while i > r
              n = this[r] or {}
              1 is n.nodeType and (b.cleanData(Ot(n, not 1))
              n.innerHTML = e
              )
              r++
            n = 0
        n and @empty().append(e)
      ), null, e, arguments_.length

    replaceWith: (e) ->
      t = b.isFunction(e)
      t or "string" is typeof e or (e = b(e).not(this).detach())
      @domManip([e], not 0, (e) ->
        t = @nextSibling
        n = @parentNode
        n and (b(this).remove()
        n.insertBefore(e, t)
        )
      )

    detach: (e) ->
      @remove e, not 0

    domManip: (e, n, r) ->
      e = f.apply([], e)
      i = undefined
      o = undefined
      a = undefined
      s = undefined
      u = undefined
      l = undefined
      c = 0
      p = @length
      d = this
      h = p - 1
      g = e[0]
      m = b.isFunction(g)
      if m or not (1 >= p or "string" isnt typeof g or b.support.checkClone) and Ct.test(g)
        return @each((i) ->
          o = d.eq(i)
          m and (e[0] = g.call(this, i, (if n then o.html() else t)))
          o.domManip(e, n, r)
        )
      if p and (l = b.buildFragment(e, this[0].ownerDocument, not 1, this)
      i = l.firstChild
      1 is l.childNodes.length and (l = i)
      i
      )
        n = n and b.nodeName(i, "tr")
        s = b.map(Ot(l, "script"), Ht)
        a = s.length

        while p > c
          o = l
          c isnt h and (o = b.clone(o, not 0, not 0)
          a and b.merge(s, Ot(o, "script"))
          )
          r.call((if n and b.nodeName(this[c], "table") then Lt(this[c], "tbody") else this[c]), o, c)
          c++
        if a
          u = s[s.length - 1].ownerDocument
          b.map(s, qt)
          c = 0

          while a > c
            o = s[c]
            kt.test(o.type or "") and not b._data(o, "globalEval") and b.contains(u, o) and ((if o.src then b.ajax(
              url: o.src
              type: "GET"
              dataType: "script"
              async: not 1
              global: not 1
              throws: not 0
            ) else b.globalEval((o.text or o.textContent or o.innerHTML or "").replace(St, ""))))
            c++
        l = i = null
      this
  )

  b.each
    appendTo: "append"
    prependTo: "prepend"
    insertBefore: "before"
    insertAfter: "after"
    replaceAll: "replaceWith"
  , (e, t) ->
    b.fn[e] = (e) ->
      n = undefined
      r = 0
      i = []
      o = b(e)
      a = o.length - 1
      while a >= r
        n = (if r is a then this else @clone(not 0))
        b(o[r])[t](n)
        d.apply(i, n.get())
        r++
      @pushStack i

  b.extend
    clone: (e, t, n) ->
      r = undefined
      i = undefined
      o = undefined
      a = undefined
      s = undefined
      u = b.contains(e.ownerDocument, e)
      if (if b.support.html5Clone or b.isXMLDoc(e) or not mt.test("<" + e.nodeName + ">") then o = e.cloneNode(not 0) else (Dt.innerHTML = e.outerHTML
      Dt.removeChild(o = Dt.firstChild)
      ))
      not (b.support.noCloneEvent and b.support.noCloneChecked or 1 isnt e.nodeType and 11 isnt e.nodeType or b.isXMLDoc(e))
        r = Ot(o)
        s = Ot(e)
        a = 0

        while null isnt (i = s[a])
          r[a] and Ft(i, r[a])
          ++a
      if t
        if n
          s = s or Ot(e)
          r = r or Ot(o)
          a = 0

          while null isnt (i = s[a])
            _t i, r[a]
            a++
        else
          _t e, o
      r = Ot(o, "script")
      r.length > 0 and Mt(r, not u and Ot(e, "script"))
      r = s = i = null
      o

    buildFragment: (e, t, n, r) ->
      i = undefined
      o = undefined
      a = undefined
      s = undefined
      u = undefined
      l = undefined
      c = undefined
      p = e.length
      f = dt(t)
      d = []
      h = 0
      while p > h
        if o = e[h]
        o or 0 is o
          if "object" is b.type(o)
            b.merge d, (if o.nodeType then [o] else o)
          else if wt.test(o)
            s = s or f.appendChild(t.createElement("div"))
            u = (bt.exec(o) or ["", ""])[1].toLowerCase()
            c = At[u] or At._default
            s.innerHTML = c[1] + o.replace(vt, "<$1></$2>") + c[2]
            i = c[0]

            s = s.lastChild  while i--
            if not b.support.leadingWhitespace and yt.test(o) and d.push(t.createTextNode(yt.exec(o)[0]))
            not b.support.tbody
              o = (if "table" isnt u or xt.test(o) then (if "<table>" isnt c[1] or xt.test(o) then 0 else s) else s.firstChild)
              i = o and o.childNodes.length

              b.nodeName(l = o.childNodes[i], "tbody") and not l.childNodes.length and o.removeChild(l)  while i--
            b.merge(d, s.childNodes)
            s.textContent = ""

            s.removeChild s.firstChild  while s.firstChild
            s = f.lastChild
          else
            d.push t.createTextNode(o)
        h++
      s and f.removeChild(s)
      b.support.appendChecked or b.grep(Ot(d, "input"), Bt)
      h = 0

      while o = d[h++]
        if (not r or -1 is b.inArray(o, r)) and (a = b.contains(o.ownerDocument, o)
        s = Ot(f.appendChild(o), "script")
        a and Mt(s)
        n
        )
          i = 0
          kt.test(o.type or "") and n.push(o)  while o = s[i++]
      s = null
      f

    cleanData: (e, t) ->
      n = undefined
      r = undefined
      o = undefined
      a = undefined
      s = 0
      u = b.expando
      l = b.cache
      p = b.support.deleteExpando
      f = b.event.special
      while null isnt (n = e[s])
        if (t or b.acceptData(n)) and (o = n[u]
        a = o and l[o]
        )
          if a.events
            for r of a.events
              (if f[r] then b.event.remove(n, r) else b.removeEvent(n, r, a.handle))
          l[o] and (delete l[o]

          (if p then delete n[u]
           else (if typeof n.removeAttribute isnt i then n.removeAttribute(u) else n[u] = null))
          c.push(o)
          )
        s++

  Pt = undefined
  Rt = undefined
  Wt = undefined
  $t = /alpha\([^)]*\)/i
  It = /opacity\s*=\s*([^)]*)/
  zt = /^(top|right|bottom|left)$/
  Xt = /^(none|table(?!-c[ea]).+)/
  Ut = /^margin/
  Vt = RegExp("^(" + x + ")(.*)$", "i")
  Yt = RegExp("^(" + x + ")(?!px)[a-z%]+$", "i")
  Jt = RegExp("^([+-])=(" + x + ")", "i")
  Gt = BODY: "block"
  Qt =
    position: "absolute"
    visibility: "hidden"
    display: "block"

  Kt =
    letterSpacing: 0
    fontWeight: 400

  Zt = ["Top", "Right", "Bottom", "Left"]
  en = ["Webkit", "O", "Moz", "ms"]
  b.fn.extend(
    css: (e, n) ->
      b.access this, ((e, n, r) ->
        i = undefined
        o = undefined
        a = {}
        s = 0
        if b.isArray(n)
          o = Rt(e)
          i = n.length

          while i > s
            a[n[s]] = b.css(e, n[s], not 1, o)
            s++
          return a
        (if r isnt t then b.style(e, n, r) else b.css(e, n))
      ), e, n, arguments_.length > 1

    show: ->
      rn this, not 0

    hide: ->
      rn this

    toggle: (e) ->
      t = "boolean" is typeof e
      @each ->
        (if ((if t then e else nn(this))) then b(this).show() else b(this).hide())

  )
  b.extend(
    cssHooks:
      opacity:
        get: (e, t) ->
          if t
            n = Wt(e, "opacity")
            (if "" is n then "1" else n)

    cssNumber:
      columnCount: not 0
      fillOpacity: not 0
      fontWeight: not 0
      lineHeight: not 0
      opacity: not 0
      orphans: not 0
      widows: not 0
      zIndex: not 0
      zoom: not 0

    cssProps:
      float: (if b.support.cssFloat then "cssFloat" else "styleFloat")

    style: (e, n, r, i) ->
      if e and 3 isnt e.nodeType and 8 isnt e.nodeType and e.style
        o = undefined
        a = undefined
        s = undefined
        u = b.camelCase(n)
        l = e.style
        return (if s and "get" of s and (o = s.get(e, not 1, i)) isnt t then o else l[n])  if n = b.cssProps[u] or (b.cssProps[u] = tn(l, u))
        s = b.cssHooks[n] or b.cssHooks[u]
        r is t

        if a = typeof r
        "string" is a and (o = Jt.exec(r)) and (r = (o[1] + 1) * o[2] + parseFloat(b.css(e, n))
        a = "number"
        )
        not (null is r or "number" is a and isNaN(r) or ("number" isnt a or b.cssNumber[u] or (r += "px")
        b.support.clearCloneStyle or "" isnt r or 0 isnt n.indexOf("background") or (l[n] = "inherit")
        s and "set" of s and (r = s.set(e, r, i)) is t
        ))
          try
            l[n] = r

    css: (e, n, r, i) ->
      o = undefined
      a = undefined
      s = undefined
      u = b.camelCase(n)
      n = b.cssProps[u] or (b.cssProps[u] = tn(e.style, u))
      s = b.cssHooks[n] or b.cssHooks[u]
      s and "get" of s and (a = s.get(e, not 0, r))
      a is t and (a = Wt(e, n, i))
      "normal" is a and n of Kt and (a = Kt[n])
      (if "" is r or r then (o = parseFloat(a)
      (if r is not 0 or b.isNumeric(o) then o or 0 else a)
      ) else a)

    swap: (e, t, n, r) ->
      i = undefined
      o = undefined
      a = {}
      for o of t
        a[o] = e.style[o]
        e.style[o] = t[o]
      i = n.apply(e, r or [])
      for o of t
        e.style[o] = a[o]
      i
  )
  (if e.getComputedStyle then (Rt = (t) ->
    e.getComputedStyle t, null

  Wt = (e, n, r) ->
    i = undefined
    o = undefined
    a = undefined
    s = r or Rt(e)
    u = (if s then s.getPropertyValue(n) or s[n] else t)
    l = e.style
    s and ("" isnt u or b.contains(e.ownerDocument, e) or (u = b.style(e, n))
    Yt.test(u) and Ut.test(n) and (i = l.width
    o = l.minWidth
    a = l.maxWidth
    l.minWidth = l.maxWidth = l.width = u
    u = s.width
    l.width = i
    l.minWidth = o
    l.maxWidth = a
    )
    )
    u

  ) else o.documentElement.currentStyle and (Rt = (e) ->
    e.currentStyle

  Wt = (e, n, r) ->
    i = undefined
    o = undefined
    a = undefined
    s = r or Rt(e)
    u = (if s then s[n] else t)
    l = e.style
    null is u and l and l[n] and (u = l[n])
    Yt.test(u) and not zt.test(n) and (i = l.left
    o = e.runtimeStyle
    a = o and o.left
    a and (o.left = e.currentStyle.left)
    l.left = (if "fontSize" is n then "1em" else u)
    u = l.pixelLeft + "px"
    l.left = i
    a and (o.left = a)
    )
    (if "" is u then "auto" else u)

  ))

  b.each(["height", "width"], (e, n) ->
    b.cssHooks[n] =
      get: (e, r, i) ->
        (if r then (if 0 is e.offsetWidth and Xt.test(b.css(e, "display")) then b.swap(e, Qt, ->
          sn e, n, i
        ) else sn(e, n, i)) else t)

      set: (e, t, r) ->
        i = r and Rt(e)
        on_ e, t, (if r then an(e, n, r, b.support.boxSizing and "border-box" is b.css(e, "boxSizing", not 1, i), i) else 0)
  )
  b.support.opacity or (b.cssHooks.opacity =
    get: (e, t) ->
      (if It.test(((if t and e.currentStyle then e.currentStyle.filter else e.style.filter)) or "") then .01 * parseFloat(RegExp.$1) + "" else (if t then "1" else ""))

    set: (e, t) ->
      n = e.style
      r = e.currentStyle
      i = (if b.isNumeric(t) then "alpha(opacity=" + 100 * t + ")" else "")
      o = r and r.filter or n.filter or ""
      n.zoom = 1
      (t >= 1 or "" is t) and "" is b.trim(o.replace($t, "")) and n.removeAttribute and (n.removeAttribute("filter")
      "" is t or r and not r.filter
      ) or (n.filter = (if $t.test(o) then o.replace($t, i) else o + " " + i))
  )
  b(->
    b.support.reliableMarginRight or (b.cssHooks.marginRight = get: (e, n) ->
      (if n then b.swap(e,
        display: "inline-block"
      , Wt, [e, "marginRight"]) else t)
    )
    not b.support.pixelPosition and b.fn.position and b.each(["top", "left"], (e, n) ->
      b.cssHooks[n] = get: (e, r) ->
        (if r then (r = Wt(e, n)
        (if Yt.test(r) then b(e).position()[n] + "px" else r)
        ) else t)
    )
  )
  b.expr and b.expr.filters and (b.expr.filters.hidden = (e) ->
    0 >= e.offsetWidth and 0 >= e.offsetHeight or not b.support.reliableHiddenOffsets and "none" is (e.style and e.style.display or b.css(e, "display"))

  b.expr.filters.visible = (e) ->
    not b.expr.filters.hidden(e)

  )
  b.each(
    margin: ""
    padding: ""
    border: "Width"
  , (e, t) ->
    b.cssHooks[e + t] = expand: (n) ->
      r = 0
      i = {}
      o = (if "string" is typeof n then n.split(" ") else [n])
      while 4 > r
        i[e + Zt[r] + t] = o[r] or o[r - 2] or o[0]
        r++
      i

    Ut.test(e) or (b.cssHooks[e + t].set = on_)
  )

  cn = /%20/g
  pn = /\[\]$/
  fn = /\r?\n/g
  dn = /^(?:submit|button|image|reset|file)$/i
  hn = /^(?:input|select|textarea|keygen)/i
  b.fn.extend(
    serialize: ->
      b.param @serializeArray()

    serializeArray: ->
      @map(->
        e = b.prop(this, "elements")
        (if e then b.makeArray(e) else this)
      ).filter(->
        e = @type
        @name and not b(this).is(":disabled") and hn.test(@nodeName) and not dn.test(e) and (@checked or not Nt.test(e))
      ).map((e, t) ->
        n = b(this).val()
        (if null is n then null else (if b.isArray(n) then b.map(n, (e) ->
          name: t.name
          value: e.replace(fn, "\r\n")
        ) else
          name: t.name
          value: n.replace(fn, "\r\n")
        ))
      ).get()
  )
  b.param = (e, n) ->
    r = undefined
    i = []
    o = (e, t) ->
      t = (if b.isFunction(t) then t() else (if null is t then "" else t))
      i[i.length] = encodeURIComponent(e) + "=" + encodeURIComponent(t)

    if n is t and (n = b.ajaxSettings and b.ajaxSettings.traditional)
    b.isArray(e) or e.jquery and not b.isPlainObject(e)
      b.each e, ->
        o @name, @value

    else
      for r of e
        gn r, e[r], n, o
    i.join("&").replace cn, "+"


  b.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "), (e, t) ->
    b.fn[t] = (e, n) ->
      (if arguments_.length > 0 then @on(t, null, e, n) else @trigger(t))
  )
  b.fn.hover = (e, t) ->
    @mouseenter(e).mouseleave t or e


  mn = undefined
  yn = undefined
  vn = b.now()
  bn = /\?/
  xn = /#.*$/
  wn = /([?&])_=[^&]*/
  Tn = /^(.*?):[ \t]*([^\r\n]*)\r?$/g
  Nn = /^(?:about|app|app-storage|.+-extension|file|res|widget):$/
  Cn = /^(?:GET|HEAD)$/
  kn = /^\/\//
  En = /^([\w.+-]+:)(?:\/\/([^\/?#:]*)(?::(\d+)|)|)/
  Sn = b.fn.load
  An = {}
  jn = {}
  Dn = "*/".concat("*")
  try
    yn = a.href
  catch Ln
    yn = o.createElement("a")
    yn.href = ""
    yn = yn.href
  mn = En.exec(yn.toLowerCase()) or []
  b.fn.load = (e, n, r) ->
    return Sn.apply(this, arguments_)  if "string" isnt typeof e and Sn
    i = undefined
    o = undefined
    a = undefined
    s = this
    u = e.indexOf(" ")
    u >= 0 and (i = e.slice(u, e.length)
    e = e.slice(0, u)
    )
    (if b.isFunction(n) then (r = n
    n = t
    ) else n and "object" is typeof n and (a = "POST"))
    s.length > 0 and b.ajax(
      url: e
      type: a
      dataType: "html"
      data: n
    ).done((e) ->
      o = arguments_
      s.html((if i then b("<div>").append(b.parseHTML(e)).find(i) else e))
    ).complete(r and (e, t) ->
      s.each r, o or [e.responseText, t, e]
    )
    this

  b.each(["ajaxStart", "ajaxStop", "ajaxComplete", "ajaxError", "ajaxSuccess", "ajaxSend"], (e, t) ->
    b.fn[t] = (e) ->
      @on t, e
  )
  b.each(["get", "post"], (e, n) ->
    b[n] = (e, r, i, o) ->
      b.isFunction(r) and (o = o or i
      i = r
      r = t
      )
      b.ajax(
        url: e
        type: n
        dataType: o
        data: r
        success: i
      )
  )
  b.extend(
    active: 0
    lastModified: {}
    etag: {}
    ajaxSettings:
      url: yn
      type: "GET"
      isLocal: Nn.test(mn[1])
      global: not 0
      processData: not 0
      async: not 0
      contentType: "application/x-www-form-urlencoded; charset=UTF-8"
      accepts:
        "*": Dn
        text: "text/plain"
        html: "text/html"
        xml: "application/xml, text/xml"
        json: "application/json, text/javascript"

      contents:
        xml: /xml/
        html: /html/
        json: /json/

      responseFields:
        xml: "responseXML"
        text: "responseText"

      converters:
        "* text": e.String
        "text html": not 0
        "text json": b.parseJSON
        "text xml": b.parseXML

      flatOptions:
        url: not 0
        context: not 0

    ajaxSetup: (e, t) ->
      (if t then Mn(Mn(e, b.ajaxSettings), t) else Mn(b.ajaxSettings, e))

    ajaxPrefilter: Hn(An)
    ajaxTransport: Hn(jn)
    ajax: (e, n) ->
      k = (e, n, r, i) ->
        c = undefined
        y = undefined
        v = undefined
        w = undefined
        T = undefined
        C = n
        2 isnt x and (x = 2
        s and clearTimeout(s)
        l = t
        a = i or ""
        N.readyState = (if e > 0 then 4 else 0)
        r and (w = _n(p, N, r))
        (if e >= 200 and 300 > e or 304 is e then (p.ifModified and (T = N.getResponseHeader("Last-Modified")
        T and (b.lastModified[o] = T)
        T = N.getResponseHeader("etag")
        T and (b.etag[o] = T)
        )
        (if 204 is e then (c = not 0
        C = "nocontent"
        ) else (if 304 is e then (c = not 0
        C = "notmodified"
        ) else (c = Fn(p, w)
        C = c.state
        y = c.data
        v = c.error
        c = not v
        )))
        ) else (v = C
        (e or not C) and (C = "error"
        0 > e and (e = 0)
        )
        ))
        N.status = e
        N.statusText = (n or C) + ""
        (if c then h.resolveWith(f, [y, C, N]) else h.rejectWith(f, [N, C, v]))
        N.statusCode(m)
        m = t
        u and d.trigger((if c then "ajaxSuccess" else "ajaxError"), [N, p, (if c then y else v)])
        g.fireWith(f, [N, C])
        u and (d.trigger("ajaxComplete", [N, p])
        --b.active or b.event.trigger("ajaxStop")
        )
        )
      "object" is typeof e and (n = e
      e = t
      )
      n = n or {}

      r = undefined
      i = undefined
      o = undefined
      a = undefined
      s = undefined
      u = undefined
      l = undefined
      c = undefined
      p = b.ajaxSetup({}, n)
      f = p.context or p
      d = (if p.context and (f.nodeType or f.jquery) then b(f) else b.event)
      h = b.Deferred()
      g = b.Callbacks("once memory")
      m = p.statusCode or {}
      y = {}
      v = {}
      x = 0
      T = "canceled"
      N =
        readyState: 0
        getResponseHeader: (e) ->
          t = undefined
          if 2 is x
            unless c
              c = {}
              c[t[1].toLowerCase()] = t[2]  while t = Tn.exec(a)
            t = c[e.toLowerCase()]
          (if null is t then null else t)

        getAllResponseHeaders: ->
          (if 2 is x then a else null)

        setRequestHeader: (e, t) ->
          n = e.toLowerCase()
          x or (e = v[n] = v[n] or e
          y[e] = t
          )
          this

        overrideMimeType: (e) ->
          x or (p.mimeType = e)
          this

        statusCode: (e) ->
          t = undefined
          if e
            if 2 > x
              for t of e
                m[t] = [m[t], e[t]]
            else
              N.always e[N.status]
          this

        abort: (e) ->
          t = e or T
          l and l.abort(t)
          k(0, t)
          this

      return N  if h.promise(N).complete = g.add
      N.success = N.done
      N.error = N.fail
      p.url = ((e or p.url or yn) + "").replace(xn, "").replace(kn, mn[1] + "//")
      p.type = n.method or n.type or p.method or p.type
      p.dataTypes = b.trim(p.dataType or "*").toLowerCase().match(w) or [""]
      null is p.crossDomain and (r = En.exec(p.url.toLowerCase())
      p.crossDomain = not (not r or r[1] is mn[1] and r[2] is mn[2] and (r[3] or ((if "http:" is r[1] then 80 else 443))) is (mn[3] or ((if "http:" is mn[1] then 80 else 443))))
      )
      p.data and p.processData and "string" isnt typeof p.data and (p.data = b.param(p.data, p.traditional))
      qn(An, p, n, N)
      2 is x

      u = p.global
      u and 0 is b.active++ and b.event.trigger("ajaxStart")
      p.type = p.type.toUpperCase()
      p.hasContent = not Cn.test(p.type)
      o = p.url
      p.hasContent or (p.data and (o = p.url += ((if bn.test(o) then "&" else "?")) + p.data
      delete p.data

      )
      p.cache is not 1 and (p.url = (if wn.test(o) then o.replace(wn, "$1_=" + vn++) else o + ((if bn.test(o) then "&" else "?")) + "_=" + vn++))
      )
      p.ifModified and (b.lastModified[o] and N.setRequestHeader("If-Modified-Since", b.lastModified[o])
      b.etag[o] and N.setRequestHeader("If-None-Match", b.etag[o])
      )
      (p.data and p.hasContent and p.contentType isnt not 1 or n.contentType) and N.setRequestHeader("Content-Type", p.contentType)
      N.setRequestHeader("Accept", (if p.dataTypes[0] and p.accepts[p.dataTypes[0]] then p.accepts[p.dataTypes[0]] + ((if "*" isnt p.dataTypes[0] then ", " + Dn + "; q=0.01" else "")) else p.accepts["*"]))

      for i of p.headers
        N.setRequestHeader i, p.headers[i]
      return N.abort()  if p.beforeSend and (p.beforeSend.call(f, N, p) is not 1 or 2 is x)
      T = "abort"
      for i of
        success: 1
        error: 1
        complete: 1
        N[i] p[i]
      if l = qn(jn, p, n, N)
        N.readyState = 1
        u and d.trigger("ajaxSend", [N, p])
        p.async and p.timeout > 0 and (s = setTimeout(->
          N.abort "timeout"
        , p.timeout))

        try
          x = 1
          l.send(y, k)
        catch C
          throw C  unless 2 > x
          k -1, C
      else
        k -1, "No Transport"
      N

    getScript: (e, n) ->
      b.get e, t, n, "script"

    getJSON: (e, t, n) ->
      b.get e, t, n, "json"
  )

  b.ajaxSetup(
    accepts:
      script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"

    contents:
      script: /(?:java|ecma)script/

    converters:
      "text script": (e) ->
        b.globalEval(e)
        e
  )
  b.ajaxPrefilter("script", (e) ->
    e.cache is t and (e.cache = not 1)
    e.crossDomain and (e.type = "GET"
    e.global = not 1
    )
  )
  b.ajaxTransport("script", (e) ->
    if e.crossDomain
      n = undefined
      r = o.head or b("head")[0] or o.documentElement
      send: (t, i) ->
        n = o.createElement("script")
        n.async = not 0
        e.scriptCharset and (n.charset = e.scriptCharset)
        n.src = e.url
        n.onload = n.onreadystatechange = (e, t) ->
          (t or not n.readyState or /loaded|complete/.test(n.readyState)) and (n.onload = n.onreadystatechange = null
          n.parentNode and n.parentNode.removeChild(n)
          n = null
          t or i(200, "success")
          )

        r.insertBefore(n, r.firstChild)

      abort: ->
        n and n.onload(t, not 0)
  )

  On = []
  Bn = /(=)\?(?=&|$)|\?\?/
  b.ajaxSetup(
    jsonp: "callback"
    jsonpCallback: ->
      e = On.pop() or b.expando + "_" + vn++
      this[e] = not 0
      e
  )
  b.ajaxPrefilter("json jsonp", (n, r, i) ->
    o = undefined
    a = undefined
    s = undefined
    u = n.jsonp isnt not 1 and ((if Bn.test(n.url) then "url" else "string" is typeof n.data and not (n.contentType or "").indexOf("application/x-www-form-urlencoded") and Bn.test(n.data) and "data"))
    (if u or "jsonp" is n.dataTypes[0] then (o = n.jsonpCallback = (if b.isFunction(n.jsonpCallback) then n.jsonpCallback() else n.jsonpCallback)
    (if u then n[u] = n[u].replace(Bn, "$1" + o) else n.jsonp isnt not 1 and (n.url += ((if bn.test(n.url) then "&" else "?")) + n.jsonp + "=" + o))
    n.converters["script json"] = ->
      s or b.error(o + " was not called")
      s[0]

    n.dataTypes[0] = "json"
    a = e[o]
    e[o] = ->
      s = arguments_

    i.always(->
      e[o] = a
      n[o] and (n.jsonpCallback = r.jsonpCallback
      On.push(o)
      )
      s and b.isFunction(a) and a(s[0])
      s = a = t
    )
    "script"
    ) else t)
  )

  Pn = undefined
  Rn = undefined
  Wn = 0
  $n = e.ActiveXObject and ->
    e = undefined
    for e of Pn
      Pn[e] t, not 0

  b.ajaxSettings.xhr = (if e.ActiveXObject then ->
    not @isLocal and In() or zn()
   else In)
  Rn = b.ajaxSettings.xhr()
  b.support.cors = !!Rn and "withCredentials" of Rn
  Rn = b.support.ajax = !!Rn
  Rn and b.ajaxTransport((n) ->
    if not n.crossDomain or b.support.cors
      r = undefined
      send: (i, o) ->
        a = undefined
        s = undefined
        u = n.xhr()
        if (if n.username then u.open(n.type, n.url, n.async, n.username, n.password) else u.open(n.type, n.url, n.async))
        n.xhrFields
          for s of n.xhrFields
            u[s] = n.xhrFields[s]
        n.mimeType and u.overrideMimeType and u.overrideMimeType(n.mimeType)
        n.crossDomain or i["X-Requested-With"] or (i["X-Requested-With"] = "XMLHttpRequest")

        try
          for s of i
            u.setRequestHeader s, i[s]
        u.send(n.hasContent and n.data or null)
        r = (e, i) ->
          s = undefined
          l = undefined
          c = undefined
          p = undefined
          try
            if r and (i or 4 is u.readyState)
              unless r = t
              a and (u.onreadystatechange = b.noop
              $n and delete Pn[a]

              )
              i
                p = {}
                s = u.status
                l = u.getAllResponseHeaders()
                "string" is typeof u.responseText and (p.text = u.responseText)

                try
                  c = u.statusText
                catch f
                  c = ""
                (if s or not n.isLocal or n.crossDomain then 1223 is s and (s = 204) else s = (if p.text then 200 else 404))
          catch d
            i or o(-1, d)
          p and o(s, c, p, l)

        (if n.async then (if 4 is u.readyState then setTimeout(r) else (a = ++Wn
        $n and (Pn or (Pn = {}
        b(e).unload($n)
        )
        Pn[a] = r
        )
        u.onreadystatechange = r
        )) else r())

      abort: ->
        r and r(t, not 0)
  )

  Xn = undefined
  Un = undefined
  Vn = /^(?:toggle|show|hide)$/
  Yn = RegExp("^(?:([+-])=|)(" + x + ")([a-z%]*)$", "i")
  Jn = /queueHooks$/
  Gn = [nr]
  Qn = "*": [(e, t) ->
    n = undefined
    r = undefined
    i = @createTween(e, t)
    o = Yn.exec(t)
    a = i.cur()
    s = +a or 0
    u = 1
    l = 20
    if o
      if n = +o[2]
      r = o[3] or ((if b.cssNumber[e] then "" else "px"))
      "px" isnt r and s
        s = b.css(i.elem, e, not 0) or n or 1
        loop
          u = u or ".5"
          s /= u
          b.style(i.elem, e, s + r)
          break unless u isnt (u = i.cur() / a) and 1 isnt u and --l
      i.unit = r
      i.start = s
      i.end = (if o[1] then s + (o[1] + 1) * n else n)
    i
  ]
  b.Animation = b.extend(er,
    tweener: (e, t) ->
      (if b.isFunction(e) then (t = e
      e = ["*"]
      ) else e = e.split(" "))
      n = undefined
      r = 0
      i = e.length
      while i > r
        n = e[r]
        Qn[n] = Qn[n] or []
        Qn[n].unshift(t)
        r++

    prefilter: (e, t) ->
      (if t then Gn.unshift(e) else Gn.push(e))
  )
  b.Tween = rr
  rr:: =
    constructor: rr
    init: (e, t, n, r, i, o) ->
      @elem = e
      @prop = n
      @easing = i or "swing"
      @options = t
      @start = @now = @cur()
      @end = r
      @unit = o or ((if b.cssNumber[n] then "" else "px"))

    cur: ->
      e = rr.propHooks[@prop]
      (if e and e.get then e.get(this) else rr.propHooks._default.get(this))

    run: (e) ->
      t = undefined
      n = rr.propHooks[@prop]
      @pos = t = (if @options.duration then b.easing[@easing](e, @options.duration * e, 0, 1, @options.duration) else e)
      @now = (@end - @start) * t + @start
      @options.step and @options.step.call(@elem, @now, this)
      (if n and n.set then n.set(this) else rr.propHooks._default.set(this))
      this

  rr::init:: = rr::
  rr.propHooks = _default:
    get: (e) ->
      t = undefined
      (if null is e.elem[e.prop] or e.elem.style and null isnt e.elem.style[e.prop] then (t = b.css(e.elem, e.prop, "")
      (if t and "auto" isnt t then t else 0)
      ) else e.elem[e.prop])

    set: (e) ->
      (if b.fx.step[e.prop] then b.fx.step[e.prop](e) else (if e.elem.style and (null isnt e.elem.style[b.cssProps[e.prop]] or b.cssHooks[e.prop]) then b.style(e.elem, e.prop, e.now + e.unit) else e.elem[e.prop] = e.now))

  rr.propHooks.scrollTop = rr.propHooks.scrollLeft = set: (e) ->
    e.elem.nodeType and e.elem.parentNode and (e.elem[e.prop] = e.now)

  b.each(["toggle", "show", "hide"], (e, t) ->
    n = b.fn[t]
    b.fn[t] = (e, r, i) ->
      (if null is e or "boolean" is typeof e then n.apply(this, arguments_) else @animate(ir(t, not 0), e, r, i))
  )
  b.fn.extend(
    fadeTo: (e, t, n, r) ->
      @filter(nn).css("opacity", 0).show().end().animate
        opacity: t
      , e, n, r

    animate: (e, t, n, r) ->
      i = b.isEmptyObject(e)
      o = b.speed(t, n, r)
      a = ->
        t = er(this, b.extend({}, e), o)
        a.finish = ->
          t.stop not 0

        (i or b._data(this, "finish")) and t.stop(not 0)

      a.finish = a
      (if i or o.queue is not 1 then @each(a) else @queue(o.queue, a))

    stop: (e, n, r) ->
      i = (e) ->
        t = e.stop
        delete e.stop

        t(r)

      "string" isnt typeof e and (r = n
      n = e
      e = t
      )
      n and e isnt not 1 and @queue(e or "fx", [])
      @each(->
        t = not 0
        n = null isnt e and e + "queueHooks"
        o = b.timers
        a = b._data(this)
        if n
          a[n] and a[n].stop and i(a[n])
        else
          for n of a
            a[n] and a[n].stop and Jn.test(n) and i(a[n])
        n = o.length
        while n--
          o[n].elem isnt this or null isnt e and o[n].queue isnt e or (o[n].anim.stop(r)
          t = not 1
          o.splice(n, 1)
          )
        (t or not r) and b.dequeue(this, e)
      )

    finish: (e) ->
      e isnt not 1 and (e = e or "fx")
      @each(->
        t = undefined
        n = b._data(this)
        r = n[e + "queue"]
        i = n[e + "queueHooks"]
        o = b.timers
        a = (if r then r.length else 0)
        n.finish = not 0
        b.queue(this, e, [])
        i and i.cur and i.cur.finish and i.cur.finish.call(this)
        t = o.length

        while t--
          o[t].elem is this and o[t].queue is e and (o[t].anim.stop(not 0)
          o.splice(t, 1)
          )
        t = 0
        while a > t
          r[t] and r[t].finish and r[t].finish.call(this)
          t++
        delete n.finish
      )
  )

  b.each(
    slideDown: ir("show")
    slideUp: ir("hide")
    slideToggle: ir("toggle")
    fadeIn:
      opacity: "show"

    fadeOut:
      opacity: "hide"

    fadeToggle:
      opacity: "toggle"
  , (e, t) ->
    b.fn[e] = (e, n, r) ->
      @animate t, e, n, r
  )
  b.speed = (e, t, n) ->
    r = (if e and "object" is typeof e then b.extend({}, e) else
      complete: n or not n and t or b.isFunction(e) and e
      duration: e
      easing: n and t or t and not b.isFunction(t) and t
    )
    r.duration = (if b.fx.off then 0 else (if "number" is typeof r.duration then r.duration else (if r.duration of b.fx.speeds then b.fx.speeds[r.duration] else b.fx.speeds._default)))
    (null is r.queue or r.queue is not 0) and (r.queue = "fx")
    r.old = r.complete
    r.complete = ->
      b.isFunction(r.old) and r.old.call(this)
      r.queue and b.dequeue(this, r.queue)

    r

  b.easing =
    linear: (e) ->
      e

    swing: (e) ->
      .5 - Math.cos(e * Math.PI) / 2

  b.timers = []
  b.fx = rr::init
  b.fx.tick = ->
    e = undefined
    n = b.timers
    r = 0
    Xn = b.now()
    while n.length > r
      e = n[r]
      e() or n[r] isnt e or n.splice(r--, 1)
      r++
    n.length or b.fx.stop()
    Xn = t

  b.fx.timer = (e) ->
    e() and b.timers.push(e) and b.fx.start()

  b.fx.interval = 13
  b.fx.start = ->
    Un or (Un = setInterval(b.fx.tick, b.fx.interval))

  b.fx.stop = ->
    clearInterval(Un)
    Un = null

  b.fx.speeds =
    slow: 600
    fast: 200
    _default: 400

  b.fx.step = {}
  b.expr and b.expr.filters and (b.expr.filters.animated = (e) ->
    b.grep(b.timers, (t) ->
      e is t.elem
    ).length
  )
  b.fn.offset = (e) ->
    if arguments_.length
      return (if e is t then this else @each((t) ->
        b.offset.setOffset this, e, t
      ))
    n = undefined
    r = undefined
    o =
      top: 0
      left: 0

    a = this[0]
    s = a and a.ownerDocument
    if s
      n = s.documentElement
      (if b.contains(n, a) then (typeof a.getBoundingClientRect isnt i and (o = a.getBoundingClientRect())
      r = or_(s)

        top: o.top + (r.pageYOffset or n.scrollTop) - (n.clientTop or 0)
        left: o.left + (r.pageXOffset or n.scrollLeft) - (n.clientLeft or 0)

      ) else o)

  b.offset = setOffset: (e, t, n) ->
    r = b.css(e, "position")
    "static" is r and (e.style.position = "relative")
    i = b(e)
    o = i.offset()
    a = b.css(e, "top")
    s = b.css(e, "left")
    u = ("absolute" is r or "fixed" is r) and b.inArray("auto", [a, s]) > -1
    l = {}
    c = {}
    p = undefined
    f = undefined
    (if u then (c = i.position()
    p = c.top
    f = c.left
    ) else (p = parseFloat(a) or 0
    f = parseFloat(s) or 0
    ))
    b.isFunction(t) and (t = t.call(e, n, o))
    null isnt t.top and (l.top = t.top - o.top + p)
    null isnt t.left and (l.left = t.left - o.left + f)
    (if "using" of t then t.using.call(e, l) else i.css(l))

  b.fn.extend(
    position: ->
      if this[0]
        e = undefined
        t = undefined
        n =
          top: 0
          left: 0

        r = this[0]
        (if "fixed" is b.css(r, "position") then t = r.getBoundingClientRect() else (e = @offsetParent()
        t = @offset()
        b.nodeName(e[0], "html") or (n = e.offset())
        n.top += b.css(e[0], "borderTopWidth", not 0)
        n.left += b.css(e[0], "borderLeftWidth", not 0)
        ))

          top: t.top - n.top - b.css(r, "marginTop", not 0)
          left: t.left - n.left - b.css(r, "marginLeft", not 0)

    offsetParent: ->
      @map ->
        e = @offsetParent or o.documentElement
        e = e.offsetParent  while e and not b.nodeName(e, "html") and "static" is b.css(e, "position")
        e or o.documentElement

  )
  b.each(
    scrollLeft: "pageXOffset"
    scrollTop: "pageYOffset"
  , (e, n) ->
    r = /Y/.test(n)
    b.fn[e] = (i) ->
      b.access this, ((e, i, o) ->
        a = or_(e)
        (if o is t then (if a then (if n of a then a[n] else a.document.documentElement[i]) else e[i]) else ((if a then a.scrollTo((if r then b(a).scrollLeft() else o), (if r then o else b(a).scrollTop())) else e[i] = o)
        t
        ))
      ), e, i, arguments_.length, null
  )

  b.each(
    Height: "height"
    Width: "width"
  , (e, n) ->
    b.each
      padding: "inner" + e
      content: n
      "": "outer" + e
    , (r, i) ->
      b.fn[i] = (i, o) ->
        a = arguments_.length and (r or "boolean" isnt typeof i)
        s = r or ((if i is not 0 or o is not 0 then "margin" else "border"))
        b.access this, ((n, r, i) ->
          o = undefined
          (if b.isWindow(n) then n.document.documentElement["client" + e] else (if 9 is n.nodeType then (o = n.documentElement
          Math.max(n.body["scroll" + e], o["scroll" + e], n.body["offset" + e], o["offset" + e], o["client" + e])
          ) else (if i is t then b.css(n, r, s) else b.style(n, r, i, s))))
        ), n, (if a then i else t), a, null

  )
  e.jQuery = e.$ = b
  "function" is typeof define and define.amd and define.amd.jQuery and define("jquery", [], ->
    b
  )
) window
