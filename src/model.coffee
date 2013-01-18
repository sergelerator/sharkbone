class OpalExtensions.Model extends (Backbone.RelationalModel || Backbone.Model)
  initialize: () ->
    super(arguments...)
    _.each(@relations, (rel) =>
      col = @get(rel.key)
      @get(rel.key).url = "#{@urlRoot}/#{@get('id')}#{col.url}"
    ) if @relations?
