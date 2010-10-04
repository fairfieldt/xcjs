class HuntScene extends XCScene
	constructor: ->
		super()
		bg = new XCSpriteNode('background.png', 320, 480)
		this.addChild(bg)
		map = new Map()
		this.addChild(map)

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
		
		dpad = new DPad()
		this.addChild(dpad)
		dpad.moveTo(320-96, 384)
		