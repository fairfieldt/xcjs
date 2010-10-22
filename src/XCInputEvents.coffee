class XCTapDownEvent extends XCEvent
	constructor: (@x, @y, @tapNumber) ->
		super("tapDown")
		
class XCTapMovedEvent extends XCEvent
	constructor:(@x, @y, @moveX, @moveY, @tapNumber) ->
		super("tapMoved")

class XCTapUpEvent extends XCEvent
	constructor: (@x, @y, @tapNumber) ->
		super("tapUp")

class XCKeyDownEvent extends XCEvent
	constructor: (@key) ->
		super("keyDown")

class XCKeyUpEvent extends XCEvent
	constructor: (@key) ->
		super("keyUp")