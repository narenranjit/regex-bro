var Range = function(){
	var charToRange = function(regex){
		var ALPHABETS = "abcdefghijklmnopqrstuvwxyz";
		var left = regex.split("-")[0];
		var right = regex.split("-")[1];

		var range = [];
		if(!isNaN(+left) && !isNaN(+right)){
			if(+left > +right){
				//throw new Error("left indice should be > right");
				return false;
			}
			for(var i=parseInt(left, 10); i<=parseInt(right, 10); i++){
				range.push(i+"");
			}
		}
		else{
			var alphaChoice = (left === left.toLowerCase()) ? ALPHABETS : ALPHABETS.toUpperCase();
			range = alphaChoice.substring(alphaChoice.indexOf(left), alphaChoice.indexOf(right)+1).split("");
		}
		return range;
	};

	return{
		_private: {
			charToRange: charToRange
		},
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

exports.Range = Range;