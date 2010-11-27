class XCAnimateAction extends XCAction
	#delay is the time to show each frame and frames is an array of
	#frame ids
	constructor: (@delay, @frames) ->
		super('XCAnimationAction')
		@currentFrame = 0
		@et = 0
		
	tick: (dt) ->
		@et -= dt
		if @et <= 0
			@owner.setFrame(@frames[@currentFrame++])
			if @currentFrame == @frames.length
				@currentFrame = 0
			@et = @delay
		return true
