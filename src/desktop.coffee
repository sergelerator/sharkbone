class OpalExtensions.Desktop
  _.extend(@, OpalExtensions.Mixin)

  # The layouts of the application are defined here.
  layouts:
    default:
      main: () -> $("#app_container #main")
      detail: () -> $("#app_container #detail")
      menu: () -> $("#app_container #main_menu")
      forms:
        primary: () -> $("#app_container #primary_form")
    login:
      main: () -> $("#login_container #main")

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
    if workSpace().html?
      workSpace().html('')
    else
      _.each(_.values(workSpace), (container) ->
        container().html('') if container().html?
      )
    @afterClear(workSpace, target)

  # Callbacks
  afterClear: (workSpace, target) ->
    _.each(@_afterClear, (callback, key) =>
      callback?.call(@, workSpace, target)
    )
