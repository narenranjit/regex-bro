var log = function(text){
	console.log(text);
}

var matchRegex = function(word, regex){
	word = word.split("");
	var wrd ={
		pLeft: 0,
		pRight: 0,
		matchSoFar: []
	}
	var reg ={
		pLeft: 0,
		pRight: 0,
		matchSoFar: []
	}
		
	function match(character, target){
		var isLiteral = (character.length === 1) && character.match(/[\w\s]/);
		var isCharacterClass = character.charAt(0) === "[";
		
		if(isLiteral){
			return character == target;
		}
		else if(isCharacterClass){
			var splitOut = character.substring(1, character.length-1).split("");
			for(var i=0; i< splitOut.length; i++){
				if(splitOut[i] == target){
					return true;
				}
			}
			return false;
		}
		return false;
	}
	var splitBlocks = function(regex){
		var split = [];
		//console.log("split", split, regex);
		
		if(regex.indexOf("[") !== -1){
			split = split.concat(regex.substring(0, regex.indexOf("[") ));
			split = split.concat(regex.substring(regex.indexOf("["), regex.indexOf("]")+1));
			
			var remaining = regex.substring(regex.indexOf("]")+1, regex.length);
			split = split.concat(splitBlocks(remaining));
		}
		else{
			split = regex.split("");
		}
		return split;
	}
	
	var chars = splitBlocks(regex);
	var matchedChars = [];
	var matchedRegex = []
	
	var doMatch = function(){
		var isEndOfRegex = (reg.pLeft == chars.length);
		var allRegexMatched = (matchedRegex.length == chars.length);
		var isEndOfWord = !word[wrd.pLeft];
		
		if(isEndOfRegex || isEndOfWord){
			if(allRegexMatched){
				//console.log("all matches found; answer is", matchedChars.join(""));
				return true;
			}
			else{
				//console.log("no matches found");
				return false;
			}
		}
		else{
			var currentR = chars[reg.pLeft];
			var currentW = word[wrd.pLeft];
			
			//console.log(currentR, currentW, match(currentR, currentW));
			if(!match(currentR, currentW)){
				wrd.pLeft++;
				reg.pLeft = 0;
				matchedChars = [];
				matchedRegex = [];
				
			}
			else{
				//initial match
				matchedChars.push(currentW);
				matchedRegex.push(currentR);
				
				reg.pLeft++;
				wrd.pLeft++;
			}
			return doMatch();
		}
		
	}
	return doMatch();
}

exports.match = matchRegex;
