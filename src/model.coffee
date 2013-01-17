# This will add support for Backbone.RelationalModel
baseModel = Backbone.RelationalModel || Backbone.Model

class OpalExtensions.Model extends baseModel
  initialize: () ->
    super(arguments...)

OpalExtensions.Model.setup() if Backbone.RelationalModel?
