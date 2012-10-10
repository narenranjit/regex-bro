CharacterClass = ->
  Range = require("../../app/scripts/Range").Range

  splitComponents = (regex) ->
    RANGE_SHORTCUTS =
      d: "0-9"
      w: "A-Za-z0-9_"
      s: " "
    hasShortCut = regex.indexOf("\\[dws]") isnt -1

    split = []
    counter = 0
    hasRange = regex.indexOf("-") isnt -1

    
    #regex.replace(/\\/g)
    if hasRange
      index = regex.indexOf("-")

      [soFar, item, remaining] = [regex.substring(0, index - 1),  regex.substring(index - 1, index + 2), regex.substring(index + 2, regex.length)]
     
      split = split.concat splitComponents(soFar)
      split = split.concat(item)
      split = split.concat(splitComponents(remaining))
    else
      split = regex.split("")
    split

  _privates:
    splitComponents: splitComponents

  has: (regex) ->

  match: (charToMatch, regexChar) ->
    splitOut = splitComponents(regexChar.substring(1, regexChar.length - 1))
    DOT = "."

    negation = splitOut[0] is "^"
    if negation
      splitOut.shift()

    for item in splitOut
      isRange = item.length > 1 and item.charAt(1) is "-"
      if isRange
        return not negation  if Range.match(charToMatch, item)
      else return not negation if charToMatch is item or item is DOT
    
    #No Matches found
    negation

exports.CharacterClass = CharacterClass()