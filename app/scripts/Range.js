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

exports.Range = Range;