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
					#console.log("****", re.test(sample), (match sample, item), item)
					if (match sample, item) != (re.test sample)
						console.log "match failed for #{item}"
						return false
			return true

	it.skip "matches regex Literals", ->
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
			"T[abc]i"
			"T[h0]i"
			"s[]0"
			"s[abc]0"
			"t[ha]i"
			"T[hi]s"
		]
		expect(@matcher testStrings).to.be.true

