Range = ->
  ##Privates
  charToRange = (regex) ->
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

  _private:
    charToRange: charToRange

  ##Public
  match: (charToMatch, regexChar) ->
    possibilities = charToRange(regexChar)
    return true for possibility in possibilities when possibility is "#{charToMatch}" 
    return false

exports.Range = Range()