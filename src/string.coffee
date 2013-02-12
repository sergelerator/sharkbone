# Some handy string manipulation methods.
unless String::trim?
  String::trim = () -> @replace(/^\s+|\s+$/g,"")
unless String::ltrim?
  String::ltrim = () -> @replace(/^\s+/g,"")
unless String::rtrim?
  String::rtrim = () -> @replace(/\s+$/g,"")
unless String::unslash?
  String::unslash = () -> @replace(/^\/+|\/+$/g,"")
unless String::capitalize?
  String::capitalize = () -> @charAt(0).toUpperCase() + @slice(1)
unless String::camelize?
  String::camelize = () ->
    _.map(@split(/\s|_|-/), (str) -> str.capitalize()).join('')
unless String::underscored?
  String::underscored = () ->
    @replace(/([a-z\d])([A-Z]+)/g, '$1_$2').replace(/[-\s]+/g, '_').toLowerCase()
unless String::army?
  String::army = (n) ->
    r = []
    while(r.length < n)
      r.push(this)
    r.join("")
unless String::leftFill?
  String::leftFill = (string, resultLength) -> ( string.army(resultLength) + this ).slice(resultLength*(-1) )
