

var Matcher = function(){

	var splitComponents = function(regex){
		return regex.split("");
	};
	var match = function(regex, character){
		return regex === character;
	};
	return{
		init: function(word, regex){
			var regexComponents = splitComponents(regex);
			var wordList  = word.split("");

			var checkMatchFromHere = function(startIndex){
				for(var i=0; i< regexComponents.length; i++){
					var wordIndex = startIndex + i;
					if(!match(regexComponents[i],wordList[wordIndex])){
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