window.Sharkbone =
  Version: '0.0.2'
  App:
    Models: {}
    Collections: {}
    Views: {}
    Routers: {}

    activeRouters: []

    options:
      pushState: false

    initialize: ->
      @initializeRouters()
      @setupBackboneRelational()
      Backbone.history.start()

    initializeRouters: (opts = @options) ->
      @activeRouters = _(@Routers).map( (router) -> new router(opts))

    setupBackboneRelational: () ->
      _(@Models).invoke('setup') if Backbone.RelationalModel?
