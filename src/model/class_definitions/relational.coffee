#==================================================================================================
# Class methods and variables for Sharkbone.Model
#
# When using Backbone.RelationalModel you may find it useful to make use of the 'Class methods'
# described here. They provide shortcuts for defining Model relationships. Just like
# ActiveRecord's has_many and such. Yippie.
#==================================================================================================
Sharkbone.ClassModules.Relational =
  #==============================================================================================
  # Relation describers
  #==============================================================================================

  # Shortcut for describing a hasMany relationship. Only a key attribute is needed for the
  # (probably) most common use case, but a wide number of options are available. The
  # documentation for this is better explained in Sharkbone's optional plug-in
  # Backbone.Relational, the same options that apply for a relation apply for this one.
  # NOTE: These describers rely on underscore.inflector.js !!!
  hasMany: (key, options = {}) ->
    if !key then throw new Error('HasMany relations require a key')
    @::relations = (@::relations || [])

    _.extend(options, {
      type: Backbone.HasMany
      key: key
    })
    _.defaults(options, {
      relatedModel: "#{@appNamespace()}Models.#{_.singularize(key).camelize()}"
      collectionType: "#{@appNamespace()}Collections.#{_.pluralize(key).camelize()}"
    })
    @::relations.push options

  # Shortcut for describing a hasOne relationship. Refer to the 'hasMany' method for more on
  # this method.
  hasOne: (key, options = {}) ->
    if !key then throw new Error('HasOne relations require a key')
    @::relations = (@::relations || [])

    _.extend(options, {
      type: Backbone.HasOne
      key: key
    })
    _.defaults(options, {
      relatedModel: "#{@appNamespace()}Models.#{_.singularize(key).camelize()}"
    })
    @::relations.push options
