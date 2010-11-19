class XCRotateAction extends XCIntervalAction
	constructor: (duration, name) ->
		super(duration, name)
		@et = 0

	tick: (dt) ->
		@et += dt
		rotation = @et * @stepAngle
		if Math.abs(rotation) > 0
			@et = 0
		if @positiveRotation and (@angle - rotation <= 0)
			rotation = @angle
		else if (not @positiveRotation) and @angle - rotation >= 0
			rotation = @angle
		@angle -= rotation
		@owner.rotateBy(rotation)
		super(dt)

class XCRotateToAction extends XCRotateAction
	constructor: (duration, @angle) ->
		super(duration, "XCRotateTo")
		@firstTick = true

	tick: (dt) ->
		if @firstTick
			@angle -= @owner.rotation()
			@stepAngle = @angle / @duration
			@positiveRotation = @angle > 0
			@firstTick = false
		super(dt)

class XCRotateByAction extends XCRotateAction
	constructor: (duration, @angle) ->
		super(duration, "XCRotateBy")
		@stepAngle = @angle / @duration
		@positiveRotation = @angle > 0