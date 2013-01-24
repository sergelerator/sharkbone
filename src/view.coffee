#==================================================================================================
# OpalExtensions.View
# Author: Sergio Morales L.
#
# The OpalExtensions.View class extends the basic Backbone.View to provide controlled mechanisms
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

class OpalExtensions.View extends Backbone.View

  #================================================================================================
  # Setup
  #================================================================================================

  _.extend(@, OpalExtensions.Mixin)

  @include OpalExtensions.ViewManager

  #================================================================================================
  # Default options
  #================================================================================================

  paginatorSelector: '.paginator'

  #================================================================================================
  # Defaults
  #================================================================================================

  initialize: () ->
    super(arguments...)
    _.bindAll(@)
    @_afterCreate = @_afterUpdate = @_afterDestroy = []
    @initializeDefaultCallbacks()

  initializeDefaultCallbacks: () ->
    @afterCreate @goToShow
    @afterUpdate @goToShow
    @afterDestroy @goToIndex

  bindings: () ->
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
    }

  #================================================================================================
  # CUD - CRUD without the Read part
  #================================================================================================

  # Attempts to create the model stored in @model and add it to the View's @collection
  create: (options) ->
    @collection.create(@model)
    @remove()
    @callbacksFor(@_afterCreate, [@model])

  # Attempts to update the model stored in @model
  update: (options) ->
    @model.save()
    @remove()
    @callbacksFor(@_afterUpdate, [@model])

  # Attempts to destroy a model specified whether by a provided 'id' or the View's @model.
  destroy: (id, options) ->
    if id? and @collection?
      @collection.get(id).destroy()
      @collection.remove(@collection.get(id))
    else if @model?
      @model.destroy()
      @remove()
    else throw new Error('Missing reference for destroying an object, forgot to supply an ID?')
    @callbacksFor(@_afterDestroy, [@model])

  #================================================================================================
  # Callback registrators
  #================================================================================================

  callbacksFor: (callbacksCollection, args) ->
    _.each(callbacksCollection, (func) ->
      func.apply(@, args)
    )
    @

  afterCreate: (func) ->
    @_afterCreate.push func

  afterUpdate: (func) ->
    @_afterUpdate.push func

  afterDestroy: (func) ->
    @_afterDestroy.push func

  #================================================================================================
  # Render methods
  #================================================================================================

  # Default render method, clears the @el property. You should always call this as
  # super(arguments...) in each of your views.
  render: () ->
    @$el.html('')
    @

  # Renders a template with the specified context's data
  renderData: (template, context) ->
    @$el.append(template(context))
    @

  # Renders a template with the specified model's data
  renderResource: (template, model) ->
    @$el.append(template())
    @modelBinder.bind(model, @el, @bindings())
    @

  # Renders a template using a collection of data, useful for rendering a list of data.
  # A jQuery containerSelector is used to append each of the list's items, this selector would
  # usually be a tbody or a div element.
  # This alternative render method makes use of a Backbone.CollectionBinder and will brutally
  # fail if @collectionBinder does not contain an instance of that Object.
  renderCollection: (template, collection, containerSelector) ->
    @$el.append(template())
    @collectionBinder.bind(collection, @$(containerSelector))
    @

  # Renders the pagination controls of @collection on the specified `selector`
  renderPagination: () ->
    $(@paginatorSelector).html(@collection.getPager())
    @

  #================================================================================================
  # Pagination
  #
  # Pagination event handlers are supposed to work with paginated collections. These default
  # handlers use the Backbone.Paginator API, you need to implement your own pagination system if
  # using that library does not please/suit you.
  #================================================================================================

  # Default handler for the prev-page event
  requestPreviousPage: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @collection.goTo(@collection.paginator_ui.currentPage -= 1)

  # Default handler for the next-page event
  requestNextPage: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @collection.goTo(@collection.paginator_ui.currentPage += 1)

  # Default handler for the page-marker event
  goToPage: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @collection.goTo(@collection.paginator_ui.currentPage = parseInt($(e.currentTarget).attr('data-value')))

  # Default handler for the first-page event
  goToFirst: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @collection.goTo(@collection.paginator_ui.currentPage = @collection.firstPage)

  # Default handler for the last-page event
  goToLast: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @collection.goTo(@collection.paginator_ui.currentPage = @collection.lastPage)

  noPage: (e) ->
    e.preventDefault()
    e.stopPropagation()

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
