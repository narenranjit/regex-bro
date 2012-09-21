var Range = function(){
	var charToRange = function(regex){
		var left = regex.split("-")[0];
		var right = regex.split("-")[1];

		var range = [];
		if(!isNaN(+left) && !isNaN(+right)){
			for(var i=parseInt(left, 10); i<parseInt(right, 10); i++){
				range.push(i+"");
			}
		}
		return range;
	};

	return{
		match: function(charToMatch, regexChar){
			var possibilities = charToRange(regexChar);
			for(var i=0; i< possibilities.length; i++){
				if(charToMatch === possibilities[i]){
					return true;
				}
			}
			return false;
		}
	};
}();

var CharacterClass = function(){
	var splitComponents = function(regex){
		var split = [];
		var counter = 0;
		if(regex.indexOf("-") !== -1){
			var index = regex.indexOf("-");

			var soFar = regex.substring(0,  index-1);
			if(soFar) split = split.concat(soFar);

			var item = regex.substring(index -1 , index+2);
			split = split.concat(item);
			
			var remaining = regex.substring(index+2, regex.length);
			split = split.concat(splitComponents(remaining));
		}
		else{
			split = regex.split("");
		}
		return split;
	};

	return{
		has: function(regex){

		},
		match: function(charToMatch, regexChar){
			var splitOut = splitComponents(regexChar.substring(1, regexChar.length-1));
			for(var i=0; i< splitOut.length; i++){

				var isRange = splitOut[i].length > 1 && splitOut[i].charAt(1) === "-";
				if(isRange){
					return Range.match(charToMatch, splitOut[i]);
				}
				else if(charToMatch == splitOut[i]){
					return true;
				}
			}
			return false;
		}
	};
}();

var Matcher = function(){
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
		init: function(word, regex){ // console.log("Evaluating", word, regex);
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

exports.match = Matcher.init;