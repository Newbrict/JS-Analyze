describe "Analyzer", ->
	beforeEach ->
		@analyzer = new Analyzer

	it "Whitelist check on fizzbuzz", ->
		syntax = esprima.parse codeSample["fizzbuzz"]
		@analyzer.whitelist.add '{ "if":{} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.whitelist.add '{ "while":{} }'
		expect(@analyzer.verify( syntax )).toBe false

	it "Whitelist check on nested If statements", ->
		syntax = esprima.parse codeSample["nestedIfs"]
		@analyzer.whitelist.add '{ "if":{"if":{}} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.whitelist.add '{ "if":{"if":{"if":{}}} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.whitelist.add '{ "if":{"if":{"if":{"if":{}}}} }'
		expect(@analyzer.verify( syntax )).toBe false

	it "Blacklist on fizzbuzz", ->
		syntax = esprima.parse codeSample["fizzbuzz"]
		@analyzer.blacklist.add '{ "while":{} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.blacklist.add '{ "for":{"for":{}} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.blacklist.add '{ "for":{"if":{}} }'
		expect(@analyzer.verify( syntax )).toBe false

	it "Blacklist on nested If statements", ->
		syntax = esprima.parse codeSample["nestedIfs"]
		@analyzer.blacklist.add '{ "if":{"if":{"if":{"if":{}}}} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.blacklist.add '{ "if":{"if":{"if":{}}} }'
		expect(@analyzer.verify( syntax )).toBe false

	it "Mixed lists on nested fizzbuzz", ->
		syntax = esprima.parse codeSample["fizzbuzz"]
		@analyzer.whitelist.add '{ "if":{} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.blacklist.add '{ "while":{} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.blacklist.add '{ "for":{"for":{}} }'
		expect(@analyzer.verify( syntax )).toBe true
		@analyzer.blacklist.add '{ "for":{"if":{}} }'
		expect(@analyzer.verify( syntax )).toBe false
