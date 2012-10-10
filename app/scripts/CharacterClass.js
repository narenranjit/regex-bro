var CharacterClass = function(){
	var Range = require('../../app/scripts/Range').Range;
	
	var splitComponents = function(regex){
		var RANGE_SHORTCUTS = {
			"d" : "0-9",
			"w" : "A-Za-z0-9_",
			"s" : " "
		}

		var split = [];
		var counter = 0;

		var hasRange = regex.indexOf("-") !== -1;
		var hasShortCut = regex.indexOf('\\[dws]') !== -1;

		for(var shortcut in RANGE_SHORTCUTS){
			//regex.replace(/\\/g)
		}


		if(hasRange){
			var index = regex.indexOf("-");

			var soFar = regex.substring(0,  index-1);
			if(soFar) split = splitComponents(soFar);

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
		_privates: {
			splitComponents: splitComponents
		},
		has: function(regex){

		},
		match: function(charToMatch, regexChar){
			var splitOut = splitComponents(regexChar.substring(1, regexChar.length-1));
			var DOT = ".";

			var negation = false;
			if(splitOut[0] === "^"){
				negation = true;
				splitOut.shift();
			}

			for(var i=0; i< splitOut.length; i++){
				var isRange = splitOut[i].length > 1 && splitOut[i].charAt(1) === "-";
				if(isRange){
					if(Range.match(charToMatch, splitOut[i]) ){
						return !negation;
					}
				}
				else if(charToMatch == splitOut[i] || splitOut[i] === DOT){
					return !negation;
				}
			}
			//No Matches found
			return negation;
		}
	};
}();

exports.CharacterClass = CharacterClass;