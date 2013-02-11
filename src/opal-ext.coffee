window.Sharkbone =
  Version: '0.0.2'
  App:
    Models: {}
    Collections: {}
    Views: {}
    Routers: {}

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
