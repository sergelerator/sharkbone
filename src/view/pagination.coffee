#==================================================================================================
# Pagination Controls
#
# Pagination event handlers are supposed to work with paginated collections. These default
# handlers use the Backbone.Paginator API, you need to implement your own pagination system if
# using that library does not please/suit you.
#==================================================================================================
class Sharkbone.Modules.PaginationControls

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
    @collection.goTo(
      @collection.paginator_ui.currentPage = parseInt($(e.currentTarget).attr('data-value'))
    )

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
