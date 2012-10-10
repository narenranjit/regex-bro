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

    (split = split.concat item) if item

    remaining = regex.substring item.length
    (split = split.concat splitComponents(remaining)) if remaining

    split

  _privates:
    splitComponents: splitComponents

  has: (regex) ->

  match: (charToMatch, regexChar) ->
    splitOut = splitComponents(regexChar.substring(1, regexChar.length - 1))
    DOT = "."

    negation = splitOut[0] is "^"
    match = !negation
    if negation
      splitOut.shift()

    for item in splitOut
      if Range.is item
        return match if Range.match(charToMatch, item)
      else 
        return match if charToMatch is item or item is DOT
    
    #No Matches found
    !match

exports.CharacterClass = CharacterClass()