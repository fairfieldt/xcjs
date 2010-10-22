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
			@angle -= @owner.rotation()
			@stepAngle = @angle / @duration
			@positiveRotation = @angle > 0
			@firstTick = false
		super(dt)

class XCRotateBy extends XCRotateAction
	constructor: (@duration, @angle) ->
		super("XCRotateBy")
		@stepAngle = @angle / @duration
		@positiveRotation = @angle > 0