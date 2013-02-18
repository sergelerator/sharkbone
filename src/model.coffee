class Sharkbone.Model extends (Backbone.RelationalModel || Backbone.Model)

  @appNamespace: () -> 'Sharkbone.App.'

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
        collectionType: "#{@appNamespace()}Collections.#{_.pluralize(key).capitalize()}"
      })
      @::relations.push options

    @hasOne: (key, options = {}) ->
      if !key then throw new Error('HasOne relations require a key')
      @::relations = (@::relations || [])

      _.extend(options, {
        type: Backbone.HasOne
        key: key
      })
      _.defaults(options, {
        relatedModel: "#{@appNamespace()}Models.#{_.singularize(key).capitalize()}"
      })
      @::relations.push options


      toJSON: ->
        if (Sharkbone.Config.ActiveRecord? and Sharkbone.Config.ActiveRecord)
          attrs = _(@attributes).clone()
          _(@relations).each((relation) =>
            attrs["#{relation.key}_attributes"] = _(attrs[relation.key]).clone()
            delete attrs[relation.key]
          )
          attrs
        else
          super(arguments...)

    #save: () ->
      ##originalJSONincludings = []
      #@originalRelations = _(@relations).map((rel) -> _(rel).clone())
      #_.each(@relations, (rel) =>
        #if (@get(rel.key).length is 0)
          ##originalJSONincludings.push {rel: rel, originalValue: rel.includeInJSON}
          #rel.includeInJSON = false
      #)
      #super(arguments...)
      #@relations = @originalRelations
      ##_.each(originalJSONincludings, (options) -> options.rel = options.originalValue)
