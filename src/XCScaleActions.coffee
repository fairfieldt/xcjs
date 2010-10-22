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
			@firstTick = false
		super(dt)
