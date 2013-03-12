root = @
root.Sharkbone =
  Version: '0.1.0'
  Config: {}
  Modules: {}
  ClassModules: {}
  App:
    Models: {}
    Collections: {}
    Views: {}
    Routers: {}
    Modules: {}

    Initializers:
      initializeRouters: (opts = @options) ->
        @activeRouters = _(@Routers).map( (router) -> new router(opts))

      setupBackboneRelational: () ->
        _(@Models).invoke('setup') if Backbone.RelationalModel?

    activeRouters: []

    options:
      pushState: false

    initialize: ->
      _(@Initializers).each((init) => init.call(@, @options))
      Backbone.history.start()
