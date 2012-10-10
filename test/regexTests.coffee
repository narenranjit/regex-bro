chai = require "chai"
expect = chai.expect

match = (require "../app/scripts/matcher").Matcher.match

describe "Regular Expressions Tester", ->
	beforeEach ->
		@sampleStrings = [
			"This is d0g b1g"
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

	it "matches regex Literals", ->
		testStrings =[
				"this"
				"is"
				"s i"
				"do"
				"dg"
				"s d0"
				"abc"
				"g"
				"0"
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
			"d0g"
			"d[0-9]g"
			"b[0-9]g"
			"b[5-9]g"
			"s[^b]"
			"1g[^b]"
			"d[^1-4]g"
		]
		expect(@matcher testStrings).to.be.true

