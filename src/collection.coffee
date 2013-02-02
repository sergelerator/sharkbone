#==================================================================================================
# Sharkbone.Collection
# Author: Sergio Morales L.
#
# The Sharkbone.Collection class does not really add anything important... except if you're
# using Backbone.Paginator. If you decide to use that plug-in (which in my humble opinion, you
# should) a lot of defaults are generated for your collections.
#
# IMPORTANT: These defaults work if your back-end API responds with a certain format. Keep reading
# to find out what you should consider for your back-end JSON responses.
#
# A `parse` function will be generated for you, this parse function can be overriden in any of
# your collections but to properly use the default implementation, your back-end will need to form
# a JSON object that looks like this:
#
# {
#   results: [{id: 1, name: 'John', last_name: 'Doe'}, {id: 2, name: 'Foo', last_name: 'Bar'}],
#   count: 304
# }
#
# The `results` key holds the actual collection of objects, while the `count` key is used to store
# the total number of objects stored in the server for that collection. It's that simple.
#==================================================================================================

class Sharkbone.Collection extends (Backbone.Paginator.requestPager || Backbone.Collection)

  initialize: () ->
    super(arguments...)

  if Backbone.Paginator.requestPager?

    DefaultPagesInRange: 4

    paginator_core:
      dataType: 'json'
      url: () -> @url

    paginator_ui:
      firstPage: 1
      currentPage: 1
      perPage: 20
      totalPages: 10
      # Extend or override paginator_ui to configure the pageLinks object, which is used as
      # the options for rendering the paginator controls.
      pageLinks:
        wrapperTag: 'ul'
        defaultClass: ''
        disabledClass: 'disabled'
        numberedPageOptions:
          class: 'page-marker'
          selectedClass: 'disabled'
          unselectedClass: ''
        first:
          label: '<<'
          class: 'first-page'
          disabledClass: 'no-page'
          isEnabled: () -> @currentPage > @firstPage
        prev:
          label: '<'
          class: 'prev-page'
          disabledClass: 'no-page'
          isEnabled: () -> @currentPage > @firstPage
        next:
          label: '>'
          class: 'next-page'
          disabledClass: 'no-page'
          isEnabled: () -> @currentPage < @lastPage
        last:
          label: '>>'
          class: 'last-page'
          disabledClass: 'no-page'
          isEnabled: () -> @currentPage < @lastPage

    server_api:
      page: () -> @currentPage
      per_page: () -> @perPage

    #==============================================================================================
    # Paginator property getters
    #==============================================================================================
    isCurrentPage: (n) ->
      @currentPage is n

    getMinPage: () ->
      @_minPage = ( @currentPage - ( @pagesInRange || @DefaultPagesInRange) )
      @_minPage = @firstPage if @_minPage < @firstPage
      @_minPage

    getMaxPage: () ->
      @_maxPage = ( @currentPage + ( @pagesInRange || @DefaultPagesInRange) )
      @_maxPage = @lastPage if @_maxPage > @lastPage
      @_maxPage

    getDisplayPages: () ->
      [@getMinPage()..@getMaxPage()]

    #==============================================================================================
    # Page number links rendering
    #==============================================================================================

    getPageNumberLink: (n) ->
      "<li class=\"#{@getPageNumberLinkClass(n)}\" data-value=\"#{n}\"><a href=\"#\">#{n}</a></li>"

    getPageNumberLinkClass: (n) ->
      "#{@pageLinks.defaultClass} #{@pageLinks.numberedPageOptions.class} #{@getExtraClassFor(n)}"

    getExtraClassFor: (n) ->
      if @isCurrentPage(n)
        @pageLinks.numberedPageOptions.selectedClass
      else
        @pageLinks.numberedPageOptions.unselectedClass

    #==============================================================================================
    # Page controls rendering
    #==============================================================================================

    getPageControl: (control) ->
      "<li class=\"#{@getPageControlClass(control)}\"><a href=\"#\">#{@pageLinks[control].label}</a></li>"

    getPageControlClass: (control) ->
      if @pageLinks[control].isEnabled.apply(@)
        @getEnabledPageControlClass(control)
      else
        @getDisabledPageControlClass(control)

    getEnabledPageControlClass: (control) ->
      "#{@pageLinks.defaultClass} #{@pageLinks[control].class}"

    getDisabledPageControlClass: (control) ->
      "#{@pageLinks.defaultClass} #{@pageLinks.disabledClass} #{@pageLinks[control].disabledClass}"

    #==============================================================================================
    # Collection's parse method, configured to properly work with pagination.
    #==============================================================================================
    parse: (response) ->
      @paginator_ui.count = response.count
      @lastPage = @availablePages = Math.ceil(response.count / @perPage)
      response.results

    #==============================================================================================
    # The one method you need to call to get the HTML markup for the paginator
    #==============================================================================================
    getPager: () ->
      return '' if @lastPage <= 1
      "<#{@pageLinks.wrapperTag}>" + @getPageControl('first') + @getPageControl('prev') +
        _.map(@getDisplayPages(), @getPageNumberLink, @).join('') +
        @getPageControl('next') + @getPageControl('last') + "</#{@pageLinks.wrapperTag}>"
