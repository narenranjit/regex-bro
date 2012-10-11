Literal = ->
  ##Privates
  DOT = "."

  ##Public
  is: (regex)->
    (regex.length is 1) and regex.match(/[\w\s]/)

  extract: (regex)->
    regex.charAt(0) if regex?.length

  match: (charToMatch, regexChar) ->
    regexChar is DOT or regexChar is charToMatch

exports.Literal = Literal()