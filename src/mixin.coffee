class Sharkbone.Mixin
  @mixinCallbacks: ['beforeInclude', 'beforeExtend', 'included', 'extended']

  @extend: (obj) ->
    proto = if (typeof obj is 'object') then obj else obj::
    proto.beforeExtend?.apply(@, proto)
    _.each(Object.keys(proto), (key) =>
      @[key] = proto[key] if key not in @mixinCallbacks
    )
    proto.extended?.apply(@, proto)
    @

  @include: (obj) ->
    proto = if (typeof obj is 'object') then obj else obj::
    proto.beforeInclude?.apply(@, proto)
    _.each(Object.keys(proto), (key) =>
      @::[key] = proto[key] if key not in @mixinCallbacks
    )
    proto.included?.apply(@::, proto)
    @
