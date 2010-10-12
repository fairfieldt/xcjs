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
			@x -= @owner.X()
			@y -= @owner.Y()
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

class XCRotateAction extends XCAction
	constructor: (name) ->
		super(name)
		@et = 0

	tick: (dt) ->
		@et += dt
		rotation = @et * @stepAngle
		if Math.abs(rotation) > 0
			@et = 0
		if @positiveRotation and (@angle - rotation <= 0)
			rotation = @angle
			@owner.removeAction(this)
		else if (not @positiveRotation) and @angle - rotation >= 0
			rotation = @angle
			@owner.removeAction(this)
		@angle -= rotation
		@owner.rotateBy(rotation)

class XCRotateTo extends XCRotateAction
	constructor: (@duration, @angle) ->
		super("XCRotateTo")
		@firstTick = true

	tick: (dt) ->
		if @firstTick
			@angle -= @owner.rotation
			@stepAngle = @angle / @duration
			@positiveRotation = @angle > 0
			@firstTick = false
		super(dt)

class XCRotateBy extends XCRotateAction
	constructor: (@duration, @angle) ->
		super("XCRotateBy")
		@stepAngle = @angle / @duration
		@positiveRotation = @angle > 0
		
class XCScaleAction extends XCAction
	constructor: (name) ->
		super(name)
		@et = 0
		@firstTick = true
	
	tick: (dt) ->
		if @scale == 0
			@owner.removeAction(this)
		@et += dt
		newScale = @et * @stepScale
		if Math.abs(newScale) > 0
			@et = 0
		if Math.abs(@scale) - Math.abs(newScale) <= 0
			newScale = @scale
		@scale -= newScale
		@owner.scaleTo(@owner.scaleX + newScale)

class XCScaleTo extends XCScaleAction
	constructor: (@duration, @scale) ->
		super("XCScaleTo")
		
	tick: (dt) ->
		if @firstTick
			@scale -= @owner.scaleX()
			@stepScale = @scale / @duration
			@firstTick = false
		super(dt)

class XCScaleBy extends XCScaleAction
	constructor: (@duration, @scale) ->
		super("XCScaleTo")

	tick: (dt) ->
		if @firstTick
			@scale =  (@scale * @owner.scaleX) - @owner.scaleX()
			@stepScale = @scale / @duration
			console.log('new scale ' + @scale + ' stepScale ' + @stepScale)
			@firstTick = false
		super(dt)
