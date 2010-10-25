#####################################################
# XCAction is the base object for the action system.
# its tick(dt) function is called once per frame and
# is passed the time since the last frame.  
# All actions should extend this class
####################################################
class XCAction
	constructor: (@name) ->
		@owner = null

	tick: (dt) ->