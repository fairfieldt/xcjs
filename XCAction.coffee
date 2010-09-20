class XCAction
	constructor: (@name) ->

	tick: (dt) ->


class XCMoveBy extends XCAction
	constructor: (@duration, @x, @y) ->
		super("XCMoveBy")
		@stepX = @x / @duration
		@stepY = @y / @duration
		
	tick: (dt) ->
		
		if Math.floor(@x) == 0 or Math.floor(@y) == 0
			@owner.removeAction(this)
		else
			moveX = @stepX * dt 
			moveY = @stepY * dt
			
			@x -= moveX
			@y -= moveY
			@owner.moveBy(moveX, moveY)

class XCMoveTo extends XCAction
	constructor: (@duration, @x, @y) ->
		super("XCMoveTo")
		@stepX = -1 
		@stepY = -1 

	tick: (dt) ->
		if @stepX == -1
			@x = @x - @owner.x
			@y = @y - @owner.y
			@stepX = @x / @duration
			@stepY = @y / @duration
		if Math.floor(@x) == 0 or Math.floor(@y) == 0 
			@owner.removeAction(this)
		else
			moveX = @stepX * dt 
			moveY = @stepY * dt
			
			@x -= moveX
			@y -= moveY
			@owner.moveBy(moveX, moveY)
		
	
		
