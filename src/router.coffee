class OpalExtensions.Router extends Backbone.Router
  _.extend(@, OpalExtensions.Mixin)

  @include OpalExtensions.ViewManager

  @defaultCollectionName: () -> @name.replace(/router|controller/gi, '')

  @collectionClass: @defaultCollectionName()

  @collectionName: @collectionClass.toLowerCase()

  @resources: (collectionName) ->
    collectionName ||= @collectionName
    @::routes ||= {}
    @::routes["#{collectionName}/index"] = 'index'
    @::routes["#{collectionName}"] = 'index'
    @::routes["#{collectionName}/new"] = 'newModel'
    @::routes["#{collectionName}/:id/edit"] = 'edit'
    @::routes["#{collectionName}/:id"] = 'show'

  initialize: () ->
    super(arguments...)

  loadData: () ->
    @collection.fetch()

  getResource: (id) ->
    @model = @collection.get(id) || new @collection.model(id: id)
    @model.fetch()
    @model
