class Sharkbone.Model extends (Backbone.RelationalModel || Backbone.Model)

  #==============================================================================================
  # Setup
  #==============================================================================================

  _.extend(@, Sharkbone.Mixin)

  @extend Sharkbone.Shared

  initialize: () ->
    super(arguments...)
    @on('change:id', () => @setupRelations.apply(@)) if Backbone.RelationalModel?
    @setupRelations?()
    @fetchCollections?()

  if Backbone.RelationalModel?
    @include Sharkbone.Modules.Relational
    @extend Sharkbone.ClassModules.Relational
