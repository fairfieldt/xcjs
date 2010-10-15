class HuntScene extends XCScene
	constructor: ->
		super()
		bg = new XCSpriteNode('resources/background.png', 320, 480)
		this.addChild(bg)
		bg.moveTo(0,0)
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

		dpad.tapDown = (event) ->
			x = event.x
			y = event.y
			direction = this.tapLocation(x, y)
			if direction == "left"
				if man.movedBlocks("left")
					man.gridMove(-1, 0)
			else if direction == "right"
				if man.movedBlocks("right")
					man.gridMove(1, 0)
			else if direction == "up"
				if man.movedBlocks("up")
					man.gridMove(0, -1)
			else if direction == "down"
				if man.movedBlocks("down")
					man.gridMove(0, 1)
			
		xc.addEventListener('tapDown', dpad)

		this.addChild(dpad)
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
		
		update: (delta) ->
			super(delta)
