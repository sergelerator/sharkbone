class OpalExtensions.Collection extends (Backbone.Paginator.requestPager || Backbone.Collection)
  initialize: () ->
    super(arguments...)

  if Backbone.Paginator.requestPager?
    paginator_core:
      dataType: 'json'
      url: () -> @url

    paginator_ui:
      firstPage: 1
      currentPage: 1
      perPage: 20
      totalPages: 10

    server_api:
      page: () -> @paginator_ui.currentPage
      per_page: () -> @paginator_ui.perPage

    parse: (response) ->
      response.results
