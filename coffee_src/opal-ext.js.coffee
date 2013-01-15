root.OpalExtensions = root.OpalExtensions || {}

class OpalExtensions.Mixin
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
    proto.included?.apply(@, proto)

    @

class OpalExtensions.ViewManager
  getDesktop: () ->
    @desktop ||= new OpalExtensions.Desktop()

  clearWorkSpace: (workSpace) ->
    @getDesktop().clear(workSpace)

  appMain: (view, viewData) ->
    @clearWorkSpace()
    @renderOn(@getDesktop().layout().main, view, viewData)

  appDetail: (view, viewData) ->
    @renderOn(@getDesktop().layout().detail, view, viewData)

  appForm: (view, viewData) ->
    @renderOn(@getDesktop().layout().forms.primary, view, viewData)

  renderOn: (container, view, viewData) ->
    $(container).html(new view(viewData).render().el)

class OpalExtensions.Desktop
  _.extend(@, OpalExtensions.Mixin)

  # The layouts of the application are defined here.
  layouts:
    default:
      main: $("#app_container #main")
      detail: $("#app_container #detail")
      menu: $("#app_container #main_menu")
      forms:
        primary: $("#app_container #primary_form")
    login:
      main: $("#login_container #main")

  # The name of the currently active desktop layout.
  activeLayoutName: 'default'

  # Returns a reference to the active layout.
  layout: () ->
    @layouts[@activeLayoutName]

  # Returns a reference to the active layout.
  getLayout: () ->
    @layouts[@activeLayoutName]

  # Clears the active layout or a sub-section of it.
  clear: (target) ->
    workSpace = if target? then @getLayout()[target] else @getLayout()
    if workSpace.html?
      workSpace.html('')
    else
      _.each(_.values(workSpace), (container) ->
        container.html('') if container.html?
      )
    @afterClear(workSpace, target)

  # Callbacks
  afterClear: (workSpace, target) ->
    _.each(@_afterClear, (callback, key) =>
      callback?.call(@, workSpace, target)
    )

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

class OpalExtensions.Collection extends Backbone.Collection

class OpalExtensions.Model extends Backbone.Model

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
