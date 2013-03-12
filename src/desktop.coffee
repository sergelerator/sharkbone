class Sharkbone.Desktop
  _.extend(@, Sharkbone.Mixin)

  # The layouts of the application are defined here.
  layouts:
    default: {}
    login: {}

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
    workSpace = workSpace() if typeof workSpace is 'function'
    if workSpace.html?
      workSpace.html('')
    else
      _.each(_.values(workSpace), (container) ->
        container = container() if typeof container is 'function'
        container.html('') if container.html?
      )
    @afterClear(workSpace, target)

  # Callbacks
  afterClear: (workSpace, target) ->
    _.each(@_afterClear, (callback, key) =>
      callback?.call(@, workSpace, target)
    )
