class OpalExtensions.Model extends (Backbone.RelationalModel || Backbone.Model)
  initialize: () ->
    super(arguments...)
    @setupRelations()

  setupRelations: () ->
    if @Backbone.RelationalModel?
      _.each(@relations, (rel) =>
        collectionUrl = @get(rel.key).url.unslash()
        @get(rel.key).url = "#{@urlRoot.unslash()}/#{@get('id')}/#{collectionUrl}"
      ) if @relations?
