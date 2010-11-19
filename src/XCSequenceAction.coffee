class XCSequenceAction extends XCAction
	constructor: (@actions) ->
		super("XCSequenceAction")
		
	tick: (dt) ->
		currentAction = @actions[0]
					
