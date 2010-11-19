#######################################################
# XCEvent is the base object for the event system.  
# All events should extend this object
######################################################
class XCEvent
	#a generic XCEvent is created with a name string
	constructor: (@name) ->
