# Some handy string manipulation methods.
String::trim = () -> @replace(/^\s+|\s+$/g,"") unless String::trim?
String::ltrim = () -> @replace(/^\s+/g,"") unless String::ltrim?
String::rtrim = () -> @replace(/\s+$/g,"") unless String::rtrim?
String::unslash = () -> @replace(/^\/+|\/+$/g,"") unless String::unslash?
String::capitalize = () -> @charAt(0).toUpperCase() + @slice(1)
String::camelize = () ->
  _.map(@split(/\s|_|-/), (str) -> str.capitalize()).join('')
