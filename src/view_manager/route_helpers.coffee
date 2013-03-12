#==================================================================================================
# Route helpers
#
# These methods provide an easy way of getting various routes for working with current resources.
#==================================================================================================
Sharkbone.Modules.RouteHelpers =

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
