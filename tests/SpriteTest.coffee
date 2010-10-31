onLoad = ->
	sprite1 = new XCSpriteNode('resources/man.png', 34, 48)
	sprite2 = new XCSpriteNode('resources/man.png', 34, 48)
	
	cs = xc.getCurrentScene()
	
	cs.addChild(sprite1)
	
	sprite1.addChild(sprite2)
	sprite2.moveTo(60, 0)
	
	sprite1.moveTo(160, 240)
	
