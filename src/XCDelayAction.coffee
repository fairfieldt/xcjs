#################################################
# an XCDelayAction simply waits for a specified
# amount of time.
#
#################################################
class XCDelayAction extends XCIntervalAction
	# create an XCDelayAction with duration, the 
	# desired amount of time, in seconds, to wait
	constructor: (duration) ->
		super(duration, 'XCDelayAction')