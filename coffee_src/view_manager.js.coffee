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
