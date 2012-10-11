Range = ->
  ##Privates
  split = (regex) ->
    ALPHABETS = "abcdefghijklmnopqrstuvwxyz"
    [left, right] = regex.split("-")
    range = []

    isStringArguments = isNaN(+left) or isNaN(+right)
    if isStringArguments
      isFirstCharLowerCase = left is left.toLowerCase()
      alphaChoice = if isFirstCharLowerCase then ALPHABETS else ALPHABETS.toUpperCase()
      range = alphaChoice.substring(alphaChoice.indexOf(left), alphaChoice.indexOf(right) + 1).split("")
    else
      (range.push "#{i}") for i in [left..right]
    
    range

  ##Public
  _private:
    charToRange: split

  is: (item)->
    item.length > 1 and item.charAt(1) is "-"

  extract: (regex)->
    regex.substring 0,3

  match: (charToMatch, regexChar) ->
    possibilities = split(regexChar)
    return true for possibility in possibilities when possibility is "#{charToMatch}" 
    return false

exports.Range = Range()