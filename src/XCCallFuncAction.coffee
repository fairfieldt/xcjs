#################################################
# an XCCallFunc action is a one hit action that
# calls a function when it fires
#
#################################################
class XCCallFuncAction extends XCAction
	# create an XCCallFuncAction with the desired function,
	# @fn
	constructor: (@fn, tag) ->
		super("XCCallFuncAction", tag)
	
	#when the action is fired, @fn is called and then the
	# action requests to be removed by returning false. 
	tick: (dt) ->
		@fn()
		return false
