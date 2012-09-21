chai = require "chai"
expect = chai.expect

match = (require "../app/scripts/matcher").match

describe "Regular Expressions Tester", ->
	beforeEach ->
		@sampleStrings = [
			"This is d0g"
		]		
			
		@matcher = (ts, samples = @sampleStrings) ->
			for sample in samples
				for item in ts
					re = new RegExp item
					if (match sample, item) != (re.test sample)
						console.log "match failed for #{item}"
						return false
			return true

	it "matches regex Literals", ->
		testStrings =[
				"this"
				"is"
				"s i"
				"do"
				"dg"
				"s d0"
				"abc"
		]
		expect(@matcher testStrings).to.be.true

	it "matches characterClasses", ->
		testStrings =[
			"t[abc]i"
			"s[]0"
			"s[abc]0"
			"t[ha]i"
			"is d[0-9]g"
			"t[hi]s"
		]
		expect(@matcher testStrings).to.be.true

