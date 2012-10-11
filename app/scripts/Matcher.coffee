Matcher = ->
  CharacterClass = require("../../app/scripts/CharClass.coffee").CharacterClass
  Literal = require("../../app/scripts/Literal.coffee").Literal

  splitComponents = (regex) ->
    split = []
    if CharacterClass.is regex
      item = CharacterClass.extract(regex)
    else
      item = Literal.extract regex

    size = 0
    if item
      size = item.length
      split = split.concat item

    remaining = regex.substring size
    (split = split.concat splitComponents(remaining)) if remaining

    split

  match = (charToMatch, regexChar) ->
    if Literal.is regexChar
      return Literal.match charToMatch,regexChar
    else if CharacterClass.is regexChar
      return CharacterClass.match(charToMatch, regexChar)  
    false

  _privates:
    matchChar: match
    splitComponents: splitComponents

  match: (word, regex) ->
    regexComponents = splitComponents(regex)
    wordList = word.split("")
    checkMatchFromHere = (startIndex) ->
      for component,index in regexComponents
        wordIndex = startIndex + index
        return false  if not wordList[wordIndex] or not match(wordList[wordIndex], component)
      true

    return true for word, index in wordList when checkMatchFromHere(index)
    return false

exports.Matcher = Matcher()