onLoad = ->

	xc.replaceScene(new HuntScene())
	addTimer(xc.getCurrentScene())
	addDPad(xc.getCurrentScene())


addTimer = (scene) ->
	timer = new XCTextNode('00:10', 'Arial', 14)

	timerAction = new XCAction("TimerAction")
	timerAction.time = 45.0
	timerAction.tick = (dt) ->
		@time -= dt
		if Math.ceil(@time) < 0
			@time = 10
		
		displayTime = if Math.ceil(@time) >= 10 then Math.ceil(@time) else '0' + Math.ceil(@time)
		@owner.setText('00:' + displayTime)

	scene.addChild(timer)
	timer.moveTo(10,340)
	timer.runAction(timerAction)

addDPad = (scene) ->
	dpad = new DPad()

	dpad.tapDown = (event) ->
		x = event.x
		y = event.y
		moveEvent = new XCEvent('moveEvent')
		moveEvent.x = x
		moveEvent.y = y

		xc.dispatchEvent(moveEvent)
		
	xc.addEventListener('tapDown', dpad)

	scene.addChild(dpad)
	dpad.moveTo(320-96, 384)
	
	dpad.tapUp = (event) ->
	man.moveDirection = 'none'
	dpad.tapDown = (event) ->
		this.handleTap(event)
	dpad.tapMoved = (event) ->
		this.handleTap(event)
	dpad.handleTap = (event) ->
		direction = this.directionPushed(event.x, event.y)
		man.moveDirection = direction
		
	xc.addEventListener('tapUp', dpad)
	xc.addEventListener('tapDown', dpad)
	xc.addEventListener('tapMoved', dpad)

