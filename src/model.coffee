class Sharkbone.Model extends (Backbone.RelationalModel || Backbone.Model)

  #==============================================================================================
  # Setup
  #==============================================================================================

  _.extend(@, Sharkbone.Mixin)

  @extend Sharkbone.Shared

  initialize: () ->
    super(arguments...)
    options = arguments[1] || {}
    options['fetch_collections'] ||= false

    @on('change:id', () => @setupRelations.apply(@)) if Backbone.RelationalModel?
    @setupRelations?()
    @fetchCollections?() if options['fetch_collections']

  if Backbone.RelationalModel?
    @include Sharkbone.Modules.Relational
    @extend Sharkbone.ClassModules.Relational
