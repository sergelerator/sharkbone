class Sharkbone.Router extends Backbone.Router
  _.extend(@, Sharkbone.Mixin)

  @include Sharkbone.ViewManager

  initialize: () ->
    super(arguments...)

  loadData: () ->
    @collection.fetch()

  getResource: (id) ->
    @model = @collection.get(id) || new @collection.model(id: id)
    @model.fetch()
    @model
