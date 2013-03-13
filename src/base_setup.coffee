root = @
root.__addMethod = (name, f) ->
  throw new TypeError('Expected a function, got something else') unless typeof f is 'function'
  unless @::[name]?
    @::[name] = f

_([Object, Number, String, Date]).each( (obj) -> obj.define = __addMethod )
