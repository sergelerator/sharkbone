class OpalExtensions.View extends Backbone.View
  _.extend(@, OpalExtensions.Mixin)

  @include OpalExtensions.ViewManager

  initialize: () ->
    super(arguments...)

  bindings: () ->
    throw new Error('You must define the bindings method in your view!')

  events:
    {
      "click .close-self" : "close"
    }

  close: (e) ->
    e.preventDefault()
    @remove()

  remove: () ->
    @modelBinder.unbind() if @modelBinder?
    @collectionBinder.unbind() if @collectionBinder?
    @$el.remove()

  renderBareTemplate: (template) ->
    @$el.html(template())

  renderResource: (template, model) ->
    @$el.html(template())
    @modelBinder.bind(model, @el, @bindings())
    @

  renderCollection: (template, collection, containerSelector) ->
    collection.fetch(
      success: () =>
        @$el.html(template())
        @collectionBinder.bind(collection, @$(containerSelector))
    )
    @

  indexPath: (direction, value, attribute, model) ->
    "##{model.urlRoot}"

  showPath: (direction, value, attribute, model) ->
    "##{model.urlRoot}/#{value}"

  editPath: (direction, value, attribute, model) ->
    "##{model.urlRoot}/#{value}/edit"
