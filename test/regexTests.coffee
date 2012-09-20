chai = require "chai"
expect = chai.expect

match = (require "../app/scripts/matcher").match

describe "Regular Expressions Tester", ->

	describe "Literals test", ->
		beforeEach ->

			@sampleString = "This is dog"
			@testStrings =[
				"this"
				"is"
				"s i"
				"do"
				"dg"
				"abc"
			]

		it "should work with complete strings", ->
			for item in @testStrings
				re = new RegExp item
				if (match @sampleString, item) != (re.test @sampleString)
					console.log "match failed for #{item}"
				expect(match @sampleString, item).to.be.equal(re.test @sampleString)

		it "should match partials", ->
