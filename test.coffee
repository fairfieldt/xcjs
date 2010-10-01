onLoad = ->

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
	alien.opacity = .5
	
	text = new XCTextNode("This is some text", "25pt Arial")
	currentScene.addChild(text)
	text.moveTo(160, 200)
	text.opacity = .2
	text.color = new XCColor(255, 0, 0)
	
	for child in currentScene.children
		console.log(child)
	test = new XCSpriteNode('dude.png', 16, 16)
	currentScene.addChild(test)
	test.moveTo(160, 240)
	
#	xc.replaceScene(new JazzScene())