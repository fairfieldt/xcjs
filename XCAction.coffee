class XCAction
	constructor: (@name) ->

	tick: (dt) ->


class XCMoveAction extends XCAction
	constructor: (name) ->
		super(name)
		@etX = 0
		@etY = 0

	tick: (dt) ->
		@etX += dt
		@etY += dt

		if @x == 0 and @y == 0
			@owner.removeAction(this)
		else
			moveX = @etX * @stepX
			moveY = @etY * @stepY
			
			if Math.abs(moveX) > 0
				@etX = 0
			if Math.abs(moveY)> 0
				@etY = 0

			if @positiveX and  (@x - moveX < 0)
				moveX = @x
			else if (not @positiveX) and (@x - moveX > 0)
				moveX = @x
			if @positiveY and (@y - moveY < 0)
				moveY = @y
			else if (not @positiveY) and (@y - moveY > 0)
				moveY = @y
			@x -= moveX
			@y -= moveY
			
			@owner.moveBy(moveX, moveY)
		

class XCMoveTo extends XCMoveAction
	constructor: (@duration, @x, @y) ->
		super("XCMoveTo")
		@firstTick = true

	tick: (dt) ->
		if @firstTick
			@x -= @owner.x
			@y -= @owner.y
			@stepX = @x / @duration
			@stepY = @y / @duration
			@positiveX = @stepX > 0
			@positiveY = @stepY > 0
			@firstTick = false
			
		super(dt)

class XCMoveBy extends XCMoveAction
	constructor: (@duration, @x, @y) ->
		super("XCMoveBy")
		@stepX = @x / @duration
		@stepY = @y / @duration
		@positiveX = @stepX > 0
		@positiveY = @stepY > 0
		
