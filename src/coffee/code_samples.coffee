# All code samples for testing will go here
@codeSample = []

# Taken from Rosetta Code
codeSample["fizzbuzz"] =
"""
	for (var i = 1; i <= 100; i++) {
		if (i % 15 === 0) {
			console.log('FizzBuzz');
		} else if (i % 3 === 0) {
			console.log('Fizz');
		} else if (i % 5 === 0) {
			console.log('Buzz');
		} else {
			console.log(i);
		}
	}
"""

codeSample["nestedIfs"] =
"""
	if ("this" == "this") {
		if(true) {
			if("that" == "that"){
				console.log( "too much truth" )
			}
		}
	}
"""

codeSample["sidebyside"] =
"""
	for (var i = 1; i <= 2; i++) {
		if(true) {
			console.log(i);
		}
		while(false) {
			console.log("can't see this");
		}
	}
"""

codeSample["sidebysideIF"] =
"""
	for (var i = 1; i <= 2; i++) {
		if(true) {
			console.log(i);
		}
	}
"""

codeSample["sidebysideWHILE"] =
"""
	for (var i = 1; i <= 2; i++) {
		while(true) {
			console.log(i);
		}
	}
"""

# All actual trials will go here
@userTrial = []

userTrial.push
	code: "// Create a program with a while loop"
	whitelist: '{ "while":{} }'
	blacklist: ''

userTrial.push
	code: "// Create a program with a for loop containing an if statement"
	whitelist: '{ "for":{"if":{}} }'
	blacklist: ''

userTrial.push
	code: "// Create a program with a for loop, and NO while loops!"
	whitelist: '{ "for":{} }'
	blacklist: '{ "while":{} }'

userTrial.push
	code: "// Create a program with an if statement containing a while and for loop"
	whitelist: '{ "if":{"while":{},"for":{}} }'
	blacklist: ''
