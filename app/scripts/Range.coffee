AlphaRange = do ->
  ALPHABETS = "abcdefghijklmnopqrstuvwxyz"

  is: (regex)->
    isNaN regex.charAt 0

  extract: (regex)->
    [left, right] = regex.split("-")
    isFirstCharLowerCase = left is left.toLowerCase()
    alphaChoice = if isFirstCharLowerCase then ALPHABETS else ALPHABETS.toUpperCase()
    alphaChoice.substring(alphaChoice.indexOf(left), alphaChoice.indexOf(right) + 1).split("")

NumberRange = do ->
  is: (regex) ->
    !isNaN regex.charAt 0

  extract: (regex) ->
    [left, right] = regex.split("-")
    ("#{i}" for i in [left..right])

Range = ->
  ##Privates
  splitComponents = (regex) ->
    if AlphaRange.is regex
      range = AlphaRange.extract regex
    else if NumberRange.is regex
      range = NumberRange.extract regex
    
    range

  ##Public
  _private:
    charToRange: splitComponents

  is: (item)->
    item.length > 1 and item.charAt(1) is "-"

  extract: (regex)->
    regex.substring 0,3

  match: (charToMatch, regexChar) ->
    possibilities = splitComponents(regexChar)
    return true for possibility in possibilities when possibility is "#{charToMatch}" 
    return false

exports.Range = Range()