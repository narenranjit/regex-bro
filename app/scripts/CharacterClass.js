var CharacterClass = function(){
	var Range = require('../../app/scripts/Range').Range;
	
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

exports.CharacterClass = CharacterClass;