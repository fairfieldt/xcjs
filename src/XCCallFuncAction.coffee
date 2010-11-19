class XCCallFuncAction extends XCAction
	constructor: (@fn) ->
		super("XCCallFuncAction")
		
	tick: (dt) ->
		@fn()