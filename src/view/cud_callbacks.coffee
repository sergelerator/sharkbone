#==================================================================================================
# CUD Callbacks
#
# This module is an add-on for Sharkbone.Modules.CUD and enables the callbacks functionality.
# Every CUD action has support for calling registered callbacks in the names specified here.
#==================================================================================================
Sharkbone.Modules.CUDCallbacks =

  _afterSuccessfulCreate:   []
  _afterSuccessfulUpdate:   []
  _afterSuccessfulDestroy:  []
  _afterFailingCreate:      []
  _afterFailingUpdate:      []
  _afterFailingDestroy:     []

  # Initialize some default callbacks for views.
  initializeDefaultCallbacks: ->
    @afterCreate @remove
    @afterCreate @goToShow
    @afterUpdate @remove
    @afterUpdate @goToShow
    @afterDestroy @goToIndex
    @

  callbacksFor: (callbacksCollection, args) ->
    _(callbacksCollection).each( (func) ->
      func.apply(@, args)
    )
    @

  afterCreate: ->
    @registerCallbacks.call(@, @_afterSuccessfulCreate, arguments)

  afterUpdate: ->
    @registerCallbacks.call(@, @_afterSuccessfulUpdate, arguments)

  afterDestroy: ->
    @registerCallbacks.call(@, @_afterSuccessfulDestroy, arguments)

  afterFailingCreate: ->
    @registerCallbacks.call(@, @_afterFailingCreate, arguments)

  afterFailingUpdate: ->
    @registerCallbacks.call(@, @_afterFailingUpdate, arguments)

  afterFailingDestroy: ->
    @registerCallbacks.call(@, @_afterFailingDestroy, arguments)

  registerCallbacks: (callbacksContainer)->
    _(Array::slice.call(arguments[1])).each( (func) =>
      @registerCallback(callbacksContainer, func)
    )

  registerCallback: (callbacksContainer, func) ->
    callbacksContainer.push(func) if typeof func is 'function'
