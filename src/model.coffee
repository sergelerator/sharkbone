class OpalExtensions.Model extends (Backbone.RelationalModel || Backbone.Model)

  @appNamespace: () -> if Opal? then "#{Opal.AppNamespace}." else ''

  initialize: () ->
    super(arguments...)
    @on('change:id', () => @setupRelations.apply(@)) if Backbone.RelationalModel?
    @setupRelations()

  setupRelations: () ->
    if Backbone.RelationalModel?
      _.each(@relations, (rel) =>
        collectionUrl = _.last(@get(rel.key).url.unslash().split('/'))
        @get(rel.key).url = "#{@urlRoot.unslash()}/#{@get('id')}/#{collectionUrl}"
      ) if @relations?

  if Backbone.RelationalModel?

    @hasMany: (key, options = {}) ->
      if !key then throw new Error('HasMany relations require a key')
      @::relations = (@::relations || [])

      _.extend(options, {
        type: Backbone.HasMany
        key: key
      })
      _.defaults(options, {
        relatedModel: "#{@appNamespace()}Models.#{_.singularize(key).capitalize()}"
        collectionType: "#{@appNamespace()}Collections.#{_.pluralize(key).capitalize()}Collection"
      })
      @::relations.push options

    save: () ->
      originalJSONincludings = []
      _.each(@relations, (rel) =>
        if (@get(rel.key).length is 0)
          originalJSONincludings.push {rel: rel, originalValue: rel.includeInJSON}
          rel.includeInJSON = false
      )
      super(arguments...)
      _.each(originalJSONincludings, (options) -> options.rel = options.originalValue)
