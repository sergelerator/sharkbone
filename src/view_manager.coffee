#==================================================================================================
# OpalExtensions.ViewManager
# Author: Sergio Morales L.
#
# The OpalExtensions.ViewManager construct aims to provide enhanced routing and rendering
# capabilities to both the OpalExtensions.View and OpalExtensions.Router constructs. Both of these
# constructs get OpalExtensions.ViewManager's attributes to manipulate the shown views inside any
# view or router.
#==================================================================================================

class OpalExtensions.ViewManager
  # Use this as your desktop instance retriever, this avoids creating multiple instances of
  # Desktop and is simple to use.
  getDesktop: () ->
    @desktop ||= new OpalExtensions.Desktop()

  # Clears a desktop work space, if no work space is provided it will clear the entire active
  # layout. The real implementation resides in the Desktop construct, this is just a shortcut.
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

  #================================================================================================
  # Navigation helpers
  #================================================================================================

   goToIndex: () ->
     Backbone.history.location.assign(@indexPath())

   goToShow: () ->
     Backbone.history.location.assign(@showPath())

  #================================================================================================
  # Route helpers
  #================================================================================================

  # Returns the plain resource root path using a provided model instance.
  # Providing a non-existent model or not providing it at all will still try to get the model
  # stored on the View's @model attribute, or in the @collection attribute if the first one does
  # not exist.
  getRootPath: (model) ->
    model?.urlRoot || @model?.urlRoot || @collection?.url

  # Returns the id of the provided resource, or the id of the View's @model attribute.
  getResourceId: (model) ->
    model?.id || @model?.id

  # This helper returns the index or root route of the view's resource. Alternatively, a model
  # can be passed as an optional argument to extract the urlRoot from there.
  indexPath: (model) ->
    urlRoot = @getRootPath(model)
    "##{urlRoot}"

  # This helper is used as a ModelBinder converter, useful for creating model's based show routes.
  showPath: (direction, value, attribute, model) ->
    urlRoot = @getRootPath(model)
    id = @getResourceId(model)
    "##{urlRoot}/#{id}"

  # This helper is used as a ModelBinder converter, useful for creating model's based edit routes.
  editPath: (direction, value, attribute, model) ->
    "#{@showPath(arguments...)}/edit"
