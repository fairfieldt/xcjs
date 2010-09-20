onLoad = ->

	currentScene = xc.getCurrentScene()

	man = new XCSpriteNode('bob.png', 32, 48)

	currentScene.addChild(man)

	man.tapDown = (event) ->
		x = event.x
		y = event.y
		man.moveTo(x, y)
	
	xc.addEventListener("tapDown", man)
	man.moveTo(320, 240)

	t = new XCTextNode("Hello, World!", "bold 36px sans-serif")
	currentScene.addChild(t)
	t.moveTo(320, 100)
