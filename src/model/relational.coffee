#==================================================================================================
# Relational Model add-ons.
#
# This module defines instance methods for Sharkbone Model, they are intended to be used when
# Sharkbone.Model extends from Backbone.RelationalModel and because of that... you should not
# use them if for some reason Backbone.RelationalModel is left out of the build.
#==================================================================================================
class Sharkbone.Modules.Relational

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
  #
  # Sharkbone.Config.ActiveRecord = true
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
