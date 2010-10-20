class HuntScene extends XCSceneNode
	constructor: ->
		@i = 1
		super()
		bg = new XCSpriteNode('resources/background.png', 320, 480)
		this.addChild(bg)
		bg.moveTo(0,0)
		@map = new Map()
		this.addChild(@map)
		@monsters = []
		man = new Man(@map, 6, 2)
		@map.man = man
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
		xc.addEventListener("TimerEvent", this)
		xc.addEventListener('GameOver', this)
		xc.addEventListener('MonsterSleep', this)

		monsterTick = new XCAction("MonsterTick")
		
		monsterTick.et = 0
		monsterTick.tick = (dt) ->
			@et += dt
			if @et >= 1.0
				xc.dispatchEvent(new XCEvent('MonsterTick'))
				@et = 0
		this.runAction(monsterTick)
	
		this.spawnMonster()


	TimerEvent: (event) ->
		this.spawnMonster()
		
	spawnMonster: ->
		coordinates = @map.getFreeSpace()
		monster = new Alien(@map, coordinates.x, coordinates.y)
		monster.name = @i++
		@monsters.push(monster)
		
	GameOver: (event) ->
		xc.getCurrentScene().pause()
		gameOverMessage = new XCTextNode('Game Over', 'Helvetica', 16)
		gameOverMessage.setColor(new XCColor(0, 0, 0))
		gameOverMessage.setAnchorX(.5)
		gameOverMessage.setAnchorY(.5)

		this.addChild(gameOverMessage)
		gameOverMessage.moveTo(160, 240)
		
	MonsterSleep: (event) ->
		allAsleep = true
		for monster in @monsters
			if not monster.asleep
				allAsleep = false
				break
				
		if allAsleep
			xc.dispatchEvent(new XCEvent('SpawnMonstersEvent'))
			for monster in @monsters
				x = monster.gridX
				y = monster.gridY
				@map.removeChild(monster)
				candy = new GridEntity('resources/candy.png', @map, 'candy', x, y)
				candy.gridMove(0,0)
	