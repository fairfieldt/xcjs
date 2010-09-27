onLoad = ->
	
	testNode = new XCScene()

	a1 = new XCAction("Action1")
	a2 = new XCAction("Action2")

	testNode.runAction(a1)
	testNode.runAction(a2)
	console.log(testNode.actions.length)
	testNode.removeAction(a2)
	for action in testNode.actions 
		console.log(action.name)
	console.log(testNode.actions.length)
	

	currentScene = xc.getCurrentScene()

	map = new Map()
	currentScene.addChild(map)
	
	man = new Man(map, 6, 2)
	map.man = man
	man.keyDown = (event) ->
		if event.key == 37
			if man.movedBlocks("left")
				man.gridMove(-1, 0)
		else if event.key == 39
			if man.movedBlocks("right")
				man.gridMove(1, 0)
		else if event.key == 38
			if man.movedBlocks("up")
				man.gridMove(0, -1)
		else if event.key == 40
			if man.movedBlocks("down")
				man.gridMove(0, 1)
	
	xc.addEventListener('keyDown', man)

	alien = new Alien(map, 10, 15)

	r = new XCRotateBy(20.0, 720)
	alien.runAction(r)
