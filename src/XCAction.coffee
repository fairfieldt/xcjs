#####################################################
# XCAction is the base object for the action system.
# its tick(dt) function is called once per frame and
# is passed the time since the last frame.  
# All actions should extend this class
####################################################
class XCAction
	#an XCAction is created with a name
	constructor: (@name) ->
		#by default, there is no owner of the action.
		@owner = null

	#the default tick does nothing.  dt is the the time in milliseconds
	# since the action was called last.  An action's tick method should
	# return true if the action should continue running or false if it
	# is done and should be removed.
	tick: (dt) ->
		return false