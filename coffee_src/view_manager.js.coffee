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
