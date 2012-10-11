CharacterClass = ->
  Range = require("../../app/scripts/Range.coffee").Range
  Literal = require("../../app/scripts/Literal.coffee").Literal

  checkList = [Range]

  splitComponents = (regex) ->
    split = []
    if Range.is regex
      item = Range.extract(regex)
    else
      item = Literal.extract regex

    if item
      split = split.concat item
      regex = regex.substring item.length

    (split = split.concat splitComponents(regex)) if regex

    split

  ##public
  _privates:
    splitComponents: splitComponents

  is: (regex) ->
    regex.charAt(0) is "["

  extract: (regex) ->
    regex.substring(0, regex.indexOf("]")+1)

  match: (charToMatch, regexChar) ->
    splitOut = splitComponents(regexChar.substring(1, regexChar.length - 1))

    negation = splitOut[0] is "^"
    match = !negation
    if negation
      splitOut.shift()

    for item in splitOut
      if Range.is item
        return match if Range.match(charToMatch, item)
      else 
        return match if Literal.match(charToMatch, item)
    
    #No Matches found
    !match

exports.CharacterClass = CharacterClass()