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
