#= require xc
#= require XCEvent

describe "XCEvent",
	beforeEach ->
		@xc = new xc()
		@listener = {Event1: (event) -> @gotEvent = true}
		
	it 'adds an event listener', ->
		@xc.addEventListener('Event1', @listener)
		expect(xc['Event1']).toHaveLength(1)
testEvents = ->
	xc = new xc()

	obj1 = {Event1: (event) -> @gotEvent = true}

	xc.addEventListener('Event1', obj1)
	
	test1 = assert(xc['Event1'].length == 1, 'addEventListener')
	
	event1 = new XCEvent('Event1')
	xc.dispatchEvent(event1)
	
	test2 = assert(obj1.gotEvent == true, 'dispatch event')
	
	obj2 = {Event1: (event) -> @gotEvent = true}
	xc.addEventListener('Event1',  obj2)
	
	xc.dispatchEvent(event1)
	
	test3 = assert(obj1.gotEvent == true and obj2.gotEvent == true, 'multiple receivers')
	
	obj1.gotEvent = false
	obj2.gotEvent = true
	xc.removeEventListener('Event1', obj1)
	test4 = assert(obj1.gotEvent == false and obj2.gotEvent == true, 'removeEventListener')
	
	passed = test1 and test2 and test3 and test4
	if passed
		console.log('Event tests OK.')
	else
		console.log('Event tests Failed.')
	
	return passed
	
eventTests = -> 
	testEvents()