scene = null
setProperty = (fn) ->
	scene.tapDown = fn
onLoad =  ->
	sprite1 = new XCSpriteNode('resources/man.png')
	
	scene = xc.getCurrentScene()
	scene.addChild(sprite1)
	sprite1.moveTo(160, 240)
	
	moveBy = new XCMoveBy(2.0, 60, -40)
	
	sprite1.runAction(moveBy)
	
	blah = eval("setProperty(function(event){console.log('testttt');});")

	xc.addEventListener('tapDown', scene)
	
