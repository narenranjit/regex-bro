expect = (require "chai").expect
Char = (require "../app/scripts/CharacterClass").CharacterClass

describe "Char Tester", ->
	describe "splits into components", ->
		beforeEach ->
			@split = Char._privates.splitComponents

		it "breaks up regular characters", ->
			expect(@split "abcd").to.eql ["a","b","c", "d"]
			expect(@split "f0g1").to.eql ["f","0","g", "1"]
			expect(@split "0").to.eql ["0"]
			expect(@split "").to.eql []
			expect(@split "a").to.eql ["a"]

		it "breaks up intger ranges", ->
			expect(@split "0-4").to.eql ["0-4"]
			expect(@split "1-9").to.eql ["1-9"]
			expect(@split "1-94").to.eql ["1-9","4"]

		it "breaks up alpa ranges", ->
			expect(@split "a-z").to.eql ["a-z"]
			expect(@split "f-g").to.eql ["f-g"]
			expect(@split "T-Y").to.eql ["T-Y"]

		it "works with mutiple ranges", ->
			expect(@split "a-z1-5").to.eql ["a-z","1-5"]
			expect(@split "14-51-5").to.eql ["1","4-5","1-5"]
			expect(@split "0a-z0-5").to.eql ["0","a-z","0-5"]
			expect(@split "0a-zabcd0-5").to.eql ["0","a-z","a","b","c","d","0-5"]
			expect(@split "0a-z0-5adsa").to.eql ["0","a-z","0-5","a","d", "s", "a"]
			expect(@split "asd0a-z0-5").to.eql ["a","s","d","0","a-z","0-5"]
			expect(@split "ab0-312g-z0-5a").to.eql ["a","b","0-3","1","2","g-z","0-5","a"]

	beforeEach ->
		match = Char.match
		@x = "sdfds"
		@testList = (list) ->
			for testString, expressions of list
				for exp in expressions.y
					result = match testString,exp
					if !result
						console.log "#{exp} did not match for #{testString}"
					expect(result).to.be.true

				for exp in expressions.n
					result = match testString,exp
					if result
						console.log "#{exp} did not match for #{testString}"
					expect(result).to.be.false

	it "matches 'any' charcters", ->
		list =
			"h":
				"y": [ "[h]", "[g-h]", "[h-i]", "[f-z]"]
				"n": ["[a]", "[1]", "[H]", "[G-H]", "[H-I]"]
			"6":
				"y": ["[1-6]", "[6-9]","[6]"]
				"n": ["[3]", "[0-5]", "[a]", "[a-z]"]
			"G":
				"y": ["[G]", "[A-Z]", "[G-H]", "[A-G]"]
				"n": ["[g_]"]
		@testList list
		

	it "matches shorthand ranges", ->
		match = Char.match

	it "works with negations", ->
		list =
			"h":
				"y": ["[^a]", "[^a-g]"]
				"n": ["[^h]", "[^a-h]"]
			"0":
				"y": ["[^a]", "[^a-z]"]
				"n": ["[^0]", "[^0-9]"]

		@testList list