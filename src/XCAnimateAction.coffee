class XCAnimateAction extends XCAction
	#delay is the time to show each frame and frames is an array of
	#frame ids
	constructor: (@delay, @frames, @repeat, tag) ->
		repeat ?= false
		super('XCAnimationAction', tag)
		@currentFrame = 0
		@et = 0
		
	tick: (dt) ->
		@et -= dt
		if @et <= 0
			@et = @delay
			@owner.setFrame(@frames[@currentFrame++])
			if @currentFrame == @frames.length
				#should we repeat?
				if @repeat
					@currentFrame = 0
				else
					console.log('done animating')
					return false
		return true
			


