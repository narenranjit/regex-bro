chai = require "chai"
expect = chai.expect

Range = (require "../app/scripts/Range").Range

describe "Range Tester", ->
	describe "converts chars to ranges", ->
		beforeEach ->
			@cTor = Range._private.charToRange

		it "works with integers", ->
			expect(@cTor "0-4").to.eql(["0", "1", "2", "3", "4"])
			expect(@cTor "0-9").to.eql(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"])
			expect(@cTor "1-5").to.eql(["1", "2", "3", "4", "5"])
			expect(@cTor "5-5").to.eql(["5"])

		it "does nt work if min > max", ->
			#expect(@cTor "5-4").to.throw("left indice should be > right")

		it "converts alpha ranges - lowerCase", ->
			expect(@cTor "a-f").to.eql ["a", "b", "c","d", "e", "f"]
			expect(@cTor "f-f").to.eql ["f"]

		it "converts alpha ranges - upperCase", ->
			expect(@cTor "A-F").to.eql ["A", "B", "C","D", "E", "F"]
			expect(@cTor "F-F").to.eql ["F"]

		it "doest noT work for mixed case alpha", ->
			#expect(@cTor "a-Z").to.throw "ssfsd"

	it "matches expressions", ->
		match = Range.match
		testList = 
			"0-4": 
				"y": ["0","4", "3", 4]
				"n": ["5",5,"a","b"]
			"g-j":
				"y": ["g", "j", "i"]
				"n": ["a", "z", 0, "1", "G", "J"]
			"K-O":
				"y": ["K", "O"]
				"n": ["k", 2, 1]
