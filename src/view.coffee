#==================================================================================================
# Sharkbone.View
# Author: Sergio Morales L.
#
# The Sharkbone.View class extends the basic Backbone.View to provide controlled mechanisms
# for rendering data templates, manipulate the DOM and declare data bindings between DOM elements
# and data models/collections.
#
# It also encapsulates a default implementation of three of the basic REST actions:
#   create
#     Just like the server-side implementation, the 'new' action provides a form to populate a new
#     object's fields, and the 'create' action performs the save operation.
#   update
#     Similar to the 'new' => 'create' equivalence, the 'edit' action needs a 'update' action to
#     perform the save operation.
#   destroy
#     This action is used to (guessed it already?) destroy a model.
#
# You should check the documentation on each method so you can know what to expect from each of
# them. NOTE: These are only default implementations that should fit some common use cases, but
# they can be easily ditched, just write your own implementation in each specific view and avoid
# calling super().
#==================================================================================================

class Sharkbone.View extends Backbone.View

  #================================================================================================
  # Setup
  #================================================================================================

  _.extend(@, Sharkbone.Mixin)

  @include Sharkbone.ViewManager
  @include Sharkbone.Modules.CUD
  @include Sharkbone.Modules.CUDCallbacks
  @include Sharkbone.Modules.Render
  @include Sharkbone.Modules.PaginationControls

  #================================================================================================
  # Defaults
  #================================================================================================

  initialize: () ->
    super(arguments...)
    _.bindAll(@)
    @initializePaginatedCollection()
    @initializeModelBinding()
    @

  initializePaginatedCollection: ->
    if @collection? and _.isFunction(@collection.getPager)
      @listenTo(@collection, 'reset', @renderPagination)
    @

  initializeModelBinding: ->
    if Backbone.ModelBinder?
      @modelBinder = new Backbone.ModelBinder()
    @

  buildCollectionBinder: (childTemplate, bindings) ->
    new Backbone.CollectionBinder(
      new Backbone.CollectionBinder.ElManagerFactory(childTemplate(), bindings())
    )

  bindings: ->
    throw new Error('You must define the bindings method in your view!')

  events:
    {
      "click .close-self"         : "close"
      "click .first-page"         : "goToFirst"
      "click .prev-page"          : "requestPreviousPage"
      "click .next-page"          : "requestNextPage"
      "click .last-page"          : "goToLast"
      "click .page-marker"        : "goToPage"
      "click .no-page"            : "noPage"
      "click a.show_detail"       : (e) -> e.stopPropagation()
      "click a.edit"              : (e) -> e.stopPropagation()
    }

  #================================================================================================
  # DOM manipulation
  #================================================================================================

  # This is the default handler for the close button click event. This event comes bundled with
  # the default events object but it can be overriden for custom behavior.
  close: (e) ->
    e.preventDefault()
    @remove()
    @goToIndex()

  # This removes the view from the DOM after unbinding any models and collection contained within.
  remove: () ->
    @modelBinder.unbind() if @modelBinder?
    @collectionBinder.unbind() if @collectionBinder?
    @$el.remove()
