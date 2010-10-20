class Timer extends XCNode
	constructor: (startTime) ->
		super()
		@time = startTime
		
		minutes = @time / 60
		seconds = @time % 60
		
		minuteString = if minutes >= 10 then '' + minutes else '0' + minutes
		secondString = if seconds >= 10 then '' + seconds else '0' + seconds
		
		@text = new XCTextNode(minuteString + ':' + secondString, 'Helvetica', 14)
		this.addChild(@text)
		@text.moveTo(10, 340)
		
		timerAction = new XCAction('TimerActin')
		timerAction.time = @time
		
		timerAction.tick = (dt) ->
			@time -= dt
			if Math.ceil(@time) < 0
				@time = @owner.time
				xc.dispatchEvent(new XCEvent('TimerEvent'))
			displayTime = if Math.ceil(@time) >= 10 then Math.ceil(@time) else '0' + Math.ceil(@time)

			minutes = Math.floor(displayTime / 60)
			seconds = displayTime % 60

			minuteString = if minutes >= 10 then '' + minutes else '0' + minutes
			secondString = if seconds >= 10 then '' + seconds else '0' + seconds
			
			@owner.text.setText(minuteString + ':' + secondString)

		this.runAction(timerAction)

