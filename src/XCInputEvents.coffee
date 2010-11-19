# These are the XCEvents raised by various inputs.


#################################################
# an XCTapDown event is created when a tap 
# (or mouse click) is detected.  
#################################################
class XCTapDownEvent extends XCEvent
	#x and y are the tap coordinates
	# and @tapNumber is the id of the tap
	# for multi-touch.  tapNumber is currently
	#unimplemented.  
	constructor: (x, y, @tapNumber) ->
		#create a point object with the x and y coords
		@point = {x:x, y:y}
		super("tapDown")

#################################################
# an XCTapMoved event is created when a current tap
# (or mouse click) moves.  
#################################################		
class XCTapMovedEvent extends XCEvent
	#x and y are the tap coordinates after the move
	# moveX and moveY are the distance the tap moved
	# since the last event.  tapNumber is the id of the
	# tap for multi-touch.  It is currently unimplemented.
	constructor:(x, y, moveX, moveY, @tapNumber) ->
		#create a point object with x and y
		@point = {x:x, y:y}
		#create a point object with moveX and moveY
		#FIXME this isn't really a point object, they are ds
		@move = {x:moveX, y:moveY}
		super("tapMoved")

#################################################
# an XCTapUp event is created when a tap (or mouse
# click) is releasted.  
#################################################
class XCTapUpEvent extends XCEvent
	#x and y are the coordinates where the
	# tap was released.  tapNumber is the
	#id of the tap for multi-touch.  It is currently
	#unimplemented.  
	constructor: (x, y, @tapNumber) ->
		#create a point object with x and y
		@point = {x:x, y:y}
		super("tapUp")

#################################################
# an XCKeyDown event is created when a keyboard
# key is pressed.  
#################################################
class XCKeyDownEvent extends XCEvent
	# @key is the id of the key that was pressed
	constructor: (@key) ->
		super("keyDown")
		
#################################################
# an XCKeyUp event is created when a pressed keyboard
# key is unpressed.
#################################################
class XCKeyUpEvent extends XCEvent
	# @key is the id of the key that was unpressed.
	constructor: (@key) ->
		super("keyUp")
