class XCEvent
	constructor: (@name) ->
		

class XCTapDownEvent extends XCEvent
	constructor: (@x, @y, @tapNumber) ->
		super("tapDown")