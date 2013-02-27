#==================================================================================================
# Render methods for View.
#
# This module encapsulates general rendering logic, it's an add-on for the View class which
# defines some handy methods to render model and collection data to the screen. It follows
# Backbone's convention of returning 'this' to allow chained calls.
#==================================================================================================
class Sharkbone.Modules.Render

  #================================================================================================
  # Default options
  #================================================================================================

  paginatorSelector: '.pagination'

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
  # This method assumes there's a valid modelBinder on 'this' view, don't use it if ModelBinder
  # was left out.
  renderResource: (template, model) ->
    @$el.append(template())
    @modelBinder.bind(model, @el, @bindings())
    @

  # Renders a template using a collection of data, useful for rendering lists.
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
