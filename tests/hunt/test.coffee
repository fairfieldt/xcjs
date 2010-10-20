onLoad = ->

	xc.replaceScene(new HuntScene())
	currentScene = xc.getCurrentScene()
	addTimer(currentScene)
	addDPad(currentScene)
	addLifeCounter(currentScene)
	addScoreCounter(currentScene)


addLifeCounter = (scene) ->
	lifeCounter = new LifeCounter(3)
	lifeCounter.ManDied = (event) ->
		console.log('man died')
		this.removeLife()
		
	xc.addEventListener('ManDied', lifeCounter)
	scene.addChild(lifeCounter)
	
addScoreCounter = (scene) ->
	scoreCounter = new ScoreCounter()
	xc.addEventListener('ScoredPoints', scoreCounter)
	scene.addChild(scoreCounter)

addTimer = (scene) ->
	timer = new Timer(700)
	scene.addChild(timer)

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

