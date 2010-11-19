class XCScaleAction extends XCIntervalAction
	constructor: (duration, name) ->
		super(duration, name)
		@etX = 0
		@etY = 0
		@firstTick = true
	
	tick: (dt) ->
		@etX += dt
		@etY += dt
		newScaleX = @etX * @stepScaleX
		newScaleY = @etY * @stepScaleY
		if Math.abs(newScaleX) > 0
			@etX = 0
		if Math.abs(newScaleY) > 0
			@etY = 0
			
		if Math.abs(@scale.x) - Math.abs(newScaleX) <= 0
			newScaleX = @scale.x
		if Math.abs(@scale.y) - Math.abs(newScaleY) <= 0
			newScaleY = @scale.y
			
		@scale.x -= newScaleY
		@scale.y -= newScaleY
		@owner.scaleXTo(@owner.scaleX() + newScaleX)
		@owner.scaleYTo(@owner.scaleY() + newScaleY)
		super(dt)

class XCScaleToAction extends XCScaleAction
	constructor: (duration, @scale) ->
		super(duration, "XCScaleTo")
		
	tick: (dt) ->
		if @firstTick
			@scale.x -= @owner.scaleX()
			@scale.y -= @owner.scaleY()
			@stepScaleX = @scale.x / @duration
			@stepScaleY = @scale.y / @duration
			@firstTick = false
		super(dt)

class XCScaleByAction extends XCScaleAction
	constructor: (duration, @scale) ->
		super(duration, "XCScaleTo")

	tick: (dt) ->
		if @firstTick
			@scale =  (@scale * @owner.scaleX) - @owner.scaleX()
			@stepScaleX = @scale.x / @duration
			@stepScaleY = @scale.y / @duration
			@firstTick = false
		super(dt)
