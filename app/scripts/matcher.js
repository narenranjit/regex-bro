var Matcher = function(){
	var CharacterClass = require('../../app/scripts/CharacterClass').CharacterClass;

	var splitComponents = function(regex){
		var split = [];		//console.log("split", split, regex);
		
		var hasCharacterClass = (regex.indexOf("[")  !== -1);	
		if(hasCharacterClass){
			split = split.concat(regex.substring(0, regex.indexOf("[") ));
			split = split.concat(regex.substring(regex.indexOf("["), regex.indexOf("]")+1));
			
			var remaining = regex.substring(regex.indexOf("]")+1, regex.length);
			split = split.concat(splitComponents(remaining));
		}
		else{
			split = regex.split("");
		}
		return split;
	};
	var match = function(charToMatch, regexChar){
		var isLiteral = (regexChar.length === 1) && regexChar.match(/[\w\s]/);
		var isCharacterClass = regexChar.charAt(0) === "[";
		
		if(isLiteral){
			return charToMatch == regexChar;
		}
		else if(isCharacterClass){
			return CharacterClass.match(charToMatch, regexChar);
		}
		return false;
	};

		
	return{
		match: function(word, regex){ // console.log("Evaluating", word, regex);
			var regexComponents = splitComponents(regex); //console.log("split = ", regexComponents);
			var wordList  = word.split("");

			var checkMatchFromHere = function(startIndex){
				// console.log("Checking match from", word.substring(startIndex, wordList.length) );
				for(var i=0; i< regexComponents.length; i++){
					var wordIndex = startIndex + i;
					if(!wordList[wordIndex] || !match(wordList[wordIndex], regexComponents[i])){
						return false;
					}
				}
				return true;
			};

			for(var j=0; j< wordList.length; j++){
				if(checkMatchFromHere(j)){
					return true;
				}
			}
			return false;
		}
	};
}();

exports.Matcher = Matcher;