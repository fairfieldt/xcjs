########################################
# These are the XCEvents raised by various
# inputs.
########################################
class XCTapDownEvent extends XCEvent
	constructor: (x, y, @tapNumber) ->
		@point = {x:x, y:y}
		super("tapDown")
		
class XCTapMovedEvent extends XCEvent
	constructor:(x, y, moveX, moveY, @tapNumber) ->
		@point = {x:x, y:y}
		@move = {x:moveX, y:moveY}
		super("tapMoved")

class XCTapUpEvent extends XCEvent
	constructor: (x, y, @tapNumber) ->
		@point = {x:x, y:y}
		super("tapUp")

class XCKeyDownEvent extends XCEvent
	constructor: (@key) ->
		super("keyDown")

class XCKeyUpEvent extends XCEvent
	constructor: (@key) ->
		super("keyUp")
