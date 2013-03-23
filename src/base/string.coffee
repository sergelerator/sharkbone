# Some handy string manipulation methods.
String.define 'trim', -> @replace(/^\s+|\s+$/g,"")
String.define 'ltrim', -> @replace(/^\s+/g,"")
String.define 'rtrim', -> @replace(/\s+$/g,"")
String.define 'unslash', -> @replace(/^\/+|\/+$/g,"")
String.define 'capitalize', -> @charAt(0).toUpperCase() + @slice(1)
String.define 'camelize', -> _.map(@split(/\s|_|-/), (str) -> str.capitalize()).join('')
String.define 'underscored', ->
  @replace(/([a-z\d])([A-Z]+)/g, '$1_$2').replace(/[-\s]+/g, '_').toLowerCase()
String.define 'army', (n) ->
  r = []
  while(r.length < n)
    r.push(this)
  r.join("")
String.define 'leftFill', (string, resultLength) ->
  ( string.army(resultLength) + @ ).slice(resultLength*(-1) )

# String conversions
String.define 'toInt', -> parseInt(@)
String.define 'toF', -> parseFloat(@)

# Boolean queries
String.define 'isBlank', -> @trim().length == 0
