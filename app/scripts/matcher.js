

var Matcher = function(){

	var splitComponents = function(regex){
		return regex.split("");
	};
	var match = function(regex, character){
		return regex === character;
	};
	return{
		init: function(word, regex){
			// console.log("Evaluating", word, regex);
			var regexComponents = splitComponents(regex);
			var wordList  = word.split("");

			var checkMatchFromHere = function(startIndex){
				// console.log("Checking match from", word.substring(startIndex, wordList.length) );
				for(var i=0; i< regexComponents.length; i++){
					// console.log("Checking", regexComponents[i]);
					var wordIndex = startIndex + i;
					if(!match(regexComponents[i],wordList[wordIndex])){
						return false;
					}
				}
				// console.log("Match found for", regex);
				return true;
			};

			for(var j=0; j< wordList.length; j++){

				if(checkMatchFromHere(j)){
					return true;
				}
			}
			// console.log("----", "returning false");
			return false;
		}
	};
}();

exports.match = Matcher.init;