class OpalExtensions.Router extends Backbone.Router
  _.extend(@, OpalExtensions.Mixin)

  @include OpalExtensions.ViewManager

  initialize: () ->
    super(arguments...)

  loadData: () ->
    @collection.fetch()

  getResource: (id) ->
    @model = @collection.get(id) || new @collection.model(id: id)
    @model.fetch()
    @model
