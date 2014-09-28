describe "Parse Array", ->
	beforeEach ->
		@pa = new ParseArray

	it "Should add/get elements properly", ->
		expect(@pa.get()).toBe('[]')
		# Add one element
		@pa.add '{ "if":{} }'
		expect(@pa.get()).toBe('[{"if":{}}]')
		# Add another element
		@pa.add '{ "while":{} }'
		expect(@pa.get()).toBe('[{"if":{}},{"while":{}}]')
