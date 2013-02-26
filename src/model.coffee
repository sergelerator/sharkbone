class Sharkbone.Model extends (Backbone.RelationalModel || Backbone.Model)

  #==============================================================================================
  # Setup
  #==============================================================================================

  _.extend(@, Sharkbone.Mixin)

  @appNamespace: () -> 'Sharkbone.App.'

  initialize: () ->
    super(arguments...)
    @on('change:id', () => @setupRelations.apply(@)) if Backbone.RelationalModel?
    @setupRelations?()
    @fetchCollections?()

  if Backbone.RelationalModel?

    #==============================================================================================
    # Backbone.RelationalModel setup
    # -------------------------------------------
    #
    # The following method defines the urls for related models/collections.
    #==============================================================================================

    setupRelations: () ->
      _.each(@relations, (rel) =>
        @get(rel.key).url = "#{@urlRoot.unslash()}/#{@get('id')}/#{rel.key}"
      ) if @relations?

    #==============================================================================================
    # Relation describers
    #==============================================================================================

    # Shortcut for describing a hasMany relationship. Only a key attribute is needed for the
    # (probably) most common use case, but a wide number of options are available. The
    # documentation for this is better explained in Sharkbone's optional plug-in
    # Backbone.Relational, the same options that apply for a relation apply for this one.
    # NOTE: These describers rely on underscore.inflector.js !!!
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

    # Shortcut for describing a hasOne relationship. Refer to the 'hasMany' method for more on
    # this method.
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

    #==============================================================================================
    # Collections tricks
    #==============================================================================================

    # Call this method to fetch default collection's data. Ex. If you define some 'HasMany'
    # relations inside of your models, call this to fetch updated data from the server.
    # NOTE: This method returns false if the model's isNew() method returns true (because it
    # should not have fetch-able collections yet)
    fetchCollections: ->
      return false if @isNew()
      _(@relations).chain()
        .filter((rel) => rel.type is Backbone.HasMany)
        .pluck('key')
        .each((key) => @get(key).fetch())
        .value()

    # If you want to use the 'dot' syntax to read your related models (instead of making a call to
    # .get('relatedModelOrCollection') just do .relatedModelOrCollection) call this method upon
    # model's initialization.
    createDotSyntaxCollectionGetters: ->
      _(@relations).chain()
        .pluck('key')
        .each((key) => @[key] = () -> @get(key))


    #==============================================================================================
    # ActiveRecord support
    # -------------------------------------------
    #
    # Although this library was thought to work with NoSQL datastores, ActiveRecord is a way too
    # common use case to be left-out. If you're working with ActiveRecord, sneak a file into your
    # application and define the ActiveRecord property in the Config namespace, setting it's value
    # to 'true'. This will tweak the encoded JSON data and make it compatible with ActiveRecord's
    # accepts_nested_attributes_for.
    #==============================================================================================

    toJSON: ->
      if (Sharkbone.Config.ActiveRecord? and Sharkbone.Config.ActiveRecord)
        attrs = _(@attributes).clone()
        _(@relations).each((relation) =>
          if (attrs[relation.key].length > 0 )
            attrs["#{relation.key}_attributes"] = _(attrs[relation.key]).clone()
          delete attrs[relation.key]
        )
        attrs
      else
        super(arguments...)
