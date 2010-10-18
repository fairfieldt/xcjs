onLoad = ->

	xc.replaceScene(new HuntScene())
	currentScene = xc.getCurrentScene()
	addTimer(currentScene)
	addDPad(currentScene)
	addLifeCounter(currentScene)


addLifeCounter = (scene) ->
	lifeCounter = new LifeCounter(3)
	lifeCounter.ManDied = (event) ->
		console.log('man died')
		this.removeLife()
		
	xc.addEventListener('ManDied', lifeCounter)
	scene.addChild(lifeCounter)

addTimer = (scene) ->
	timer = new XCTextNode('00:10', 'Arial', 14)

	timerAction = new XCAction("TimerAction")
	timerAction.length = 15
	timerAction.time = timerAction.length
	timerAction.tick = (dt) ->
		@time -= dt
		if Math.ceil(@time) < 0
			@time = @length
			xc.dispatchEvent(new XCEvent('TimerEvent'))
		displayTime = if Math.ceil(@time) >= 10 then Math.ceil(@time) else '0' + Math.ceil(@time)
		@owner.setText('00:' + displayTime)

	scene.addChild(timer)
	timer.moveTo(10,340)
	timer.runAction(timerAction)

addDPad = (scene) ->
	dpad = new DPad()

	scene.addChild(dpad)
	dpad.moveTo(320-96, 384)
	
	dpad.tapUp = (event) ->
		moveInput = new XCAction('MoveEvent')
		moveInput.direction = 'none'
		xc.dispatchEvent(moveInput)
	dpad.tapDown = (event) ->
		this.handleTap(event)
	dpad.tapMoved = (event) ->
		this.handleTap(event)
	dpad.handleTap = (event) ->
		direction = this.directionPushed(event.x, event.y)
		
		moveInput = new XCAction('MoveEvent')
		moveInput.direction = direction
		
		xc.dispatchEvent(moveInput)
		
	xc.addEventListener('tapUp', dpad)
	xc.addEventListener('tapDown', dpad)
	xc.addEventListener('tapMoved', dpad)

