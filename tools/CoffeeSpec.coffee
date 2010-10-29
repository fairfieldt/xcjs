errors = []

describe = (testName, tests...) ->
	console.log('Testing ' + testName)
	
	setup = ->
	teardown = ->
	for test in tests
		foundSetup = false
		foundTeardown = false
		if test.name == 'setup'
			setup = test.run
			i = tests.indexOf(test)
			tests = tests[0...i].concat(tests[i+1..])
			foundSetup = true
			
		if test.name == 'teardown'
			teardown = test.run
			i = tests.indexOf(test)
			tests = tests[0...i].concat(tests[i+1..])
			foundTeardown = true
		if foundSetup and foundTeardown
			break
	testCount = tests.length
	failCount = 0
	for test in tests
		message = '\t' + test.name
		if not test.run(setup, teardown)
			message += ' Fail: ' + ++failCount
		console.log(message)
	if failCount > 0
		console.log('\n')
		i = 1
		for error in errors
			console.log(i++ + ': ' + error)
			
	console.log('\n' + testCount + ' tests, ' + failCount + ' failures')


it = (name, test) ->
	{name:name, run:(setup, teardown) -> 
		this.setup = setup
		this.setup()
		this.test = test
		try
			result = this.test()
		catch e
			result = false
			errors.push(e.name +  ' in ' + name + ': ' + e.message)
		this.teardown = teardown
		this.teardown()
		result}
	
expect = (value) -> new Expect(value)

beforeEach = (setup) -> {name:'setup', run:setup}

class Expect
	constructor: (@value) -> 
	
	toEqual: (expectedValue) ->
		if @value == expectedValue
			return true
		else
			throw {name: 'toEqualError', message:'Expected ' + expectedValue + ', got ' + @value}
			return false

	notToEqual: (expectedValue) -> 
		if @value != expectedValue
			return true
		else
			throw {name: 'notToEqualError', message:expectedValue + ' equals ' + @value}
			return false
			
	toHaveLength: (expectedLength) ->
		unless @value.length?
		 	throw {name: 'NoLengthPropertyError', message:'Object has no length property'}
		else if @value.length == expectedLength
			return true
		else
			throw {name: 'toHaveLengthError', message:'Expected length of ' + expectedLength + ', got ' + @value.length}
			
	toThrowException: (exceptionName) ->
		unless typeof @value is 'function'
			throw {name: 'NotAFunctionError', message:'object is not a function; cannot throw an exception'}
		else
			try
				@value()
			catch e
				if e.name == exceptionName
					return true
				else
					throw e
			throw {name: 'toThrowExceptionError', message:'function did not throw ' + exceptionName}