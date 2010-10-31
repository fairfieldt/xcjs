onLoad =  ->
	sprite1 = new XCSpriteNode('resources/man.png', 34, 48)
	
	scene = xc.getCurrentScene()
	scene.addChild(sprite1)
	sprite1.moveTo(160, 240)
	
	moveBy = new XCMoveBy(2.0, 60, -40)
	
	sprite1.runAction(moveBy)
	
	scene.tapDown = (event) -> console.log(event.x + ' ' + event.y)
	xc.addEventListener('tapDown', scene)