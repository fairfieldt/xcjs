#=require <CoffeeSpec>
#= require xc
#= require XCEvent

describe "XCEvent",
	beforeEach ->
		@xc = new xc()
		@listener = {Event1: (event) -> }
		
	it 'adds an event listener', ->
		@xc.addEventListener('Event1', @listener)
		expect(@xc['Event1']).toHaveLength(1)
		
	it 'removes an event listener', ->
		@xc.addEventListener('Event1', @listener)
		@xc.removeEventListener('Event1', @listener)
		expect(@xc['Event1']).toHaveLength(0)
		
	it 'removes an event listener', ->
		@xc.addEventListener('Event1', @listener)
		
		@listener2 = {Event1: (event) ->}
		@xc.addEventListener('Event1', @listener2)
		@xc.removeEventListener('Event1', @listener)
		expect(@xc['Event1']).toHaveLength(1)

	it 'removes an event that wasn\'t added', ->
		expect(=>@xc.removeEventListener('Event1', @listener)).toThrow('NoSuchEventListenerError')
		
	it 'adds an event listener twice', ->
		@xc.addEventListener('Event1', @listener)
		expect(=>@xc.addEventListener('Event1', @listener)).toThrow('EventListenerAlreadyAddedError')
		
		
	it 'dispatches an event', ->
		watch(@listener, 'Event1')
		@xc.addEventListener('Event1', @listener)
		@xc.dispatchEvent(new XCEvent('Event1'))
		expect(@listener.Event1).toHaveBeenCalled()
	
	it 'dispatches and event to multiple receivers', ->
		@listener2 = {Event1: (event) ->}
		watch @listener, 'Event1'
		watch @listener2, 'Event1'
		@xc.addEventListener('Event1', @listener)
		@xc.addEventListener('Event1', @listener2)
		
		@xc.dispatchEvent(new XCEvent('Event1'))
		
		expect(@listener.Event1).toHaveBeenCalled() and
		expect(@listener2.Event1).toHaveBeenCalled()
		
