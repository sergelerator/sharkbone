#==================================================================================================
# CUD - CRUD without the Read part
#
# This module defines three actions that would be handled by a Controller in a traditional MVC
# approach. However, the routes handled by a Backbone.Router are usually for serving a particular
# view (or set of views), they handle the Read part of a traditional CRUD. The rest of the actions
# affect data models and can optionally redirect the app to an application route upon completion.
#
# This module can optionally work with the callbacks module (which is a part of the Sharkbone
# build), allowing views to define certain tasks to be run upon successful or failing actions.
#==================================================================================================
Sharkbone.Modules.CUD =

  # Attempts to create the model stored in @model and add it to the View's @collection
  create: (options = {}) ->
    options.preventDefault?()
    options.stopPropagation?()
    options = {} if options.originalEvent?
    @collection.create(@model, _({
      success: () => @runCallbacksFor(@_afterSuccessfulCreate, @model)
      error: () => @runCallbacksFor(@_afterFailingCreate, @model)
    }).defaults(options))

  # Attempts to update the model stored in @model
  update: (options = {}) ->
    options.preventDefault?()
    options.stopPropagation?()
    options = {} if options.originalEvent?
    @model.save(undefined, _({
      success: () => @runCallbacksFor(@_afterSuccessfulUpdate, @model)
      error: () => @runCallbacksFor(@_afterFailingUpdate, @model)
    }).defaults(options))

  # Attempts to destroy a model specified whether by a provided 'id' or the View's @model.
  destroy: (id = {}, options = {}) ->
    id.preventDefault?()
    id.stopPropagation?()
    return @model unless @__destroyConfirmation()
    options = _({
      success: () => @runCallbacksFor(@_afterSuccessfulDestroy, @model)
      error: () => @runCallbacksFor(@_afterFailingDestroy, @model)
    }).defaults(options)
    if id? and @collection? and (model = @collection.get(id))
      model.destroy(options)
      @collection.remove(@collection.get(id))
    else if @model?
      @model.destroy(options)
    else throw new Error('Missing reference for destroying an object, forgot to supply an ID?')

  # The callback runner checks if callbacks are enabled and runs them.
  # The callback implementation lives in Sharkbone.Modules.CUDCallbacks
  runCallbacksFor: ->
    @callbacksFor?(arguments...)

  # Registers a callback to be executed before the 'destroy' method, this callback should
  # be able to return a Falsy or Truthy value. If it return a Truthy value, the destroy
  # operation is performed, otherwise it is not
  destroyConfirmation: (func) ->
    @__destroyConfirmation = if typeof func is 'function' then func else -> func
    @

  # Default destroy confirmation
  __destroyConfirmation: -> confirm('This is a destructive operation and it cannot be undone. Confirm?')
