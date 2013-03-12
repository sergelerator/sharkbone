#==================================================================================================
# Sharkbone.ViewManager
# Author: Sergio Morales L.
#
# The Sharkbone.ViewManager construct aims to provide enhanced routing and rendering
# capabilities to both the Sharkbone.View and Sharkbone.Router constructs. Both of these
# constructs get Sharkbone.ViewManager's attributes to manipulate the shown views inside any
# view or router.
#==================================================================================================

class Sharkbone.ViewManager

  _.extend(@, Sharkbone.Mixin)

  # Use this as your desktop instance retriever, this avoids creating multiple instances of
  # Desktop and is simple to use.
  getDesktop: () ->
    @desktop ||= new Sharkbone.Desktop()

  # Clears a desktop work space, if no work space is provided it will clear the entire active
  # layout. The real implementation resides in the Desktop construct, this is just a shortcut.
  clearWorkSpace: (workSpace) ->
    @getDesktop().clear(workSpace)

  renderOn: (container, view, viewData) ->
    $(container).html(new view(viewData).render().el)

  @include Sharkbone.Modules.NavigationHelpers
  @include Sharkbone.Modules.RouteHelpers
