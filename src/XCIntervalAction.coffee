###############################################
# XCIntervalAction is the base class for actions
# that run for a finite amount of time
###############################################
class XCIntervalAction extends XCAction
	# to create an XCIntervalAction, give it the @duration of time to run
	constructor: (@duration, name) ->
		super(name)
	
	# the interval action's tick subtracts
	# the time since it was last called from the total
	# when @duration is less than 0 it's run its course
	tick: (dt) ->
		@duration -= dt
		#if durantion is <= 0, the action is done.  return false
		return @duration > 0