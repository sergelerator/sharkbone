#==================================================================================================
# Navigation helpers
#
# These helpers provide easy navigation to the resources different locations.
#==================================================================================================
Sharkbone.Modules.NavigationHelpers =

   goToIndex: () ->
     Backbone.history.location.assign(@indexPath())

   goToShow: () ->
     Backbone.history.location.assign(@showPath())
