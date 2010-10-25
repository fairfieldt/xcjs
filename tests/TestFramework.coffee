assert = (test, message) ->
	unless test is true
		console.log('Fail: ' + message)
	return test