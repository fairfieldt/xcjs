class Timer extends XCNode
	constructor: (startTime) ->
		super()
		@time = startTime
		
		minutes = @time / 60
		seconds = @time % 60
		
		minuteString = if minutes >= 10 then '' + minutes else '0' + minutes
		secondString = if seconds >= 10 then '' + seconds else '0' + seconds
		
		@text = new XCTextNode(minuteString + ':' + secondString, 'Helvetica', 14)
		this.addChild(@text)
		@text.moveTo(10, 340)
		
		timerAction = new XCAction('TimerActin')
		timerAction.time = @time
		
		timerAction.tick = (dt) ->
			@time -= dt
			if Math.ceil(@time) < 0
				@time = @owner.time
				xc.dispatchEvent(new XCEvent('TimerEvent'))
			displayTime = if Math.ceil(@time) >= 10 then Math.ceil(@time) else '0' + Math.ceil(@time)

			minutes = Math.floor(displayTime / 60)
			seconds = displayTime % 60

			minuteString = if minutes >= 10 then '' + minutes else '0' + minutes
			secondString = if seconds >= 10 then '' + seconds else '0' + seconds
			
			@owner.text.setText(minuteString + ':' + secondString)

		this.runAction(timerAction)


#= require AClass

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


class ScoreCounter extends XCNode
	constructor: ->
		super()
		@scoreLabel = new XCTextNode('Score: 0', 'Helvetica', 12)
		@score = 0
		this.addChild(@scoreLabel)
		
		@scoreLabel.moveTo(10, 390)
		
		
	addScore: (amount) ->
		@score += amount
		
		newText = 'Score: ' + @score
		
		@scoreLabel.setText(newText)
		
	ScoredPoints: (event) ->
		this.addScore(event.points)
class Timer extends XCNode
	constructor: (startTime) ->
		super()
		@time = startTime
		
		minutes = @time / 60
		seconds = @time % 60
		
		minuteString = if minutes >= 10 then '' + minutes else '0' + minutes
		secondString = if seconds >= 10 then '' + seconds else '0' + seconds
		
		@text = new XCTextNode(minuteString + ':' + secondString, 'Helvetica', 14)
		this.addChild(@text)
		@text.moveTo(10, 340)
		
		timerAction = new XCAction('TimerActin')
		timerAction.time = @time
		
		timerAction.tick = (dt) ->
			@time -= dt
			if Math.ceil(@time) < 0
				@time = @owner.time
				xc.dispatchEvent(new XCEvent('TimerEvent'))
			displayTime = if Math.ceil(@time) >= 10 then Math.ceil(@time) else '0' + Math.ceil(@time)

			minutes = Math.floor(displayTime / 60)
			seconds = displayTime % 60

			minuteString = if minutes >= 10 then '' + minutes else '0' + minutes
			secondString = if seconds >= 10 then '' + seconds else '0' + seconds
			
			@owner.text.setText(minuteString + ':' + secondString)

		this.runAction(timerAction)


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


class ScoreCounter extends XCNode
	constructor: ->
		super()
		@scoreLabel = new XCTextNode('Score: 0', 'Helvetica', 12)
		@score = 0
		this.addChild(@scoreLabel)
		
		@scoreLabel.moveTo(10, 390)
		
		
	addScore: (amount) ->
		@score += amount
		
		newText = 'Score: ' + @score
		
		@scoreLabel.setText(newText)
		
	ScoredPoints: (event) ->
		this.addScore(event.points)
class Timer extends XCNode
	constructor: (startTime) ->
		super()
		@time = startTime
		
		minutes = @time / 60
		seconds = @time % 60
		
		minuteString = if minutes >= 10 then '' + minutes else '0' + minutes
		secondString = if seconds >= 10 then '' + seconds else '0' + seconds
		
		@text = new XCTextNode(minuteString + ':' + secondString, 'Helvetica', 14)
		this.addChild(@text)
		@text.moveTo(10, 340)
		
		timerAction = new XCAction('TimerActin')
		timerAction.time = @time
		
		timerAction.tick = (dt) ->
			@time -= dt
			if Math.ceil(@time) < 0
				@time = @owner.time
				xc.dispatchEvent(new XCEvent('TimerEvent'))
			displayTime = if Math.ceil(@time) >= 10 then Math.ceil(@time) else '0' + Math.ceil(@time)

			minutes = Math.floor(displayTime / 60)
			seconds = displayTime % 60

			minuteString = if minutes >= 10 then '' + minutes else '0' + minutes
			secondString = if seconds >= 10 then '' + seconds else '0' + seconds
			
			@owner.text.setText(minuteString + ':' + secondString)

		this.runAction(timerAction)


class ScoreCounter extends XCNode
	constructor: ->
		super()
		@scoreLabel = new XCTextNode('Score: 0', 'Helvetica', 12)
		@score = 0
		this.addChild(@scoreLabel)
		
		@scoreLabel.moveTo(10, 390)
		
		
	addScore: (amount) ->
		@score += amount
		
		newText = 'Score: ' + @score
		
		@scoreLabel.setText(newText)
		
	ScoredPoints: (event) ->
		this.addScore(event.points)
class Map extends XCNode
	constructor: () ->
		super()
		this.loadMap()
		
	loadMap: ->
	
		map = []
		`
		map.width = 20
		map.height = 20
		map.tileSize = 16
		map.tiles= [
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			]
	`
		@width = map.width
		@height = map.height
		@gridSize = 16

		@tiles = new Array(@width)
		for i in [0 .. @width]
			@tiles[i] = new Array(@height)
			
		for x in [0 ... @width]
			for y in [0 ... @height]
				type = map.tiles[y][x]
				fileName = ""
				if type == "#"
					console.log('a wall')
					fileName = "resources/grave.png"
				else if type == "@"
					fileName = "resources/pumpkin.png"
				
				if fileName != ""
					console.log(x + ' ' + y)
					@tiles[x][y] = new GridEntity(fileName, this, type, x, y)
				else
					empty = []
					empty.type = "empty"
					@tiles[x][y] = "empty"
					
					
	moveableBlock: (block) ->  block.type != '#'
	
	getFreeSpace: ->
			x = Math.floor(Math.random() * @width)
			y = Math.floor(Math.random() * @height)
			console.log(x + ' ' + y)
			while @tiles[x][y] != 'empty'
				x = Math.floor(Math.random() * @width)
				y = Math.floor(Math.random() * @height)
				
			return {x: x, y: y}

class GridEntity extends XCSpriteNode
	constructor: (imageName, @map, @type, @gridX, @gridY) ->

		super(imageName, @map.gridSize, @map.gridSize)
		this.setX( @gridX * @map.gridSize)
		this.setY(@gridY * @map.gridSize)
		
		@map.addChild(this)
		
	gridMove: (x, y) ->
		@map.tiles[@gridX][@gridY] = "empty"
		@map.tiles[@gridX+x][@gridY+y] = this
		this.moveBy(x * @map.gridSize, y * @map.gridSize)
		this.gridX += x
		this.gridY += y

class Man extends GridEntity
	constructor: (map, x, y) ->
		super('resources/dude.png', map, "$", x, y)
		@direction = {'up': [-0,  -1], down: [0, 1], 'left': [-1, 0], 'right': [1,0]}
		@moveDirection = 'none'
		
		moveAction = new XCAction('ManMoveAction')
		moveAction.delay = 0
		moveAction.tick = (dt) ->
			@delay -= dt
			if @owner.moveDirection != 'none' and @delay <= 0
				if @owner.movedBlocks(@owner.moveDirection)
					@owner.gridMove(@owner.direction[@owner.moveDirection][0], @owner.direction[@owner.moveDirection][1])
					@delay = .2
		this.runAction(moveAction)

		xc.addEventListener('MoveEvent', this)
		
	movedBlocks: (direction) ->
		if direction == "left"
			this.horizontalMove(-1)
		else if direction == "right"
			this.horizontalMove(1)
		else if direction == "up"
			this.verticalMove(-1)
		else if direction == "down"
			this.verticalMove(1)
			
	horizontalMove: (direction) ->
		currentX = @gridX
		y = @gridY
		
		block = @map.tiles[currentX + direction][y]
		
		while block != "empty"
			if not @map.moveableBlock(block)
				return false
			else
				currentX += direction
				block = @map.tiles[currentX + direction][y]
				
		while (currentX < @gridX and direction == -1) or (currentX > @gridX and direction == 1)
			if @map.tiles[currentX + direction][y] != "empty"
				console.log("BAD LOGIC")
			@map.tiles[currentX][y].gridMove(direction, 0)
			currentX -= direction
			
		return true
		
	verticalMove: (direction) ->
		currentY = @gridY
		x = @gridX

		block = @map.tiles[x][currentY + direction]

		while block != "empty"
			if not @map.moveableBlock(block)
				return false
			else
				currentY += direction
				block = @map.tiles[x][currentY + direction]

		while (currentY < @gridY and direction == -1) or (currentY > @gridY and direction == 1)
			if @map.tiles[x][currentY + direction] != "empty"
				console.log("BAD LOGIC")
			@map.tiles[x][currentY].gridMove(0, direction)
			currentY -= direction

		return true
		
	die: ->
		xc.dispatchEvent(new XCEvent('ManDied'))
		newPos = @map.getFreeSpace()
		this.gridMove(newPos.x - @gridX, newPos.y - @gridY)

	MoveEvent: (event) ->
		this.moveDirection = event.direction
		

class LifeCounter extends XCNode
	constructor: (@lifeCount) ->
		super()
		@man = new XCSpriteNode('resources/dude.png', 16, 16)
		this.addChild(@man)
		@man.moveTo(10,352)
		
		lifeString = 'x' + @lifeCount
		@lifeCounter = new XCTextNode(lifeString, 'Helvetica', 12)
		
		this.addChild(@lifeCounter)
		@lifeCounter.moveTo(30, 365)
		
	addLife: ->
		@lifeCount += 1
		this.update()
		
	removeLife: ->
		@lifeCount -= 1
		this.update()
		if @lifeCount <= 0
			xc.dispatchEvent(new XCEvent('GameOver'))
		
		
	update: ->
		lifeString = 'x' + @lifeCount
		@lifeCounter.setText(lifeString)
		  
		
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
	
class DPad extends XCSpriteNode
	constructor: ->
		super('resources/dpad.png', 96, 96)
		xc.addEventListener('tapDown', this)

	tapDown: (event) ->
		x = event.x
		y = event.y

		if event.x > 320 - 96 and event.x < 320 and event.y > 384 and event.y < 480
			console.log('this tap belongs to me')

	directionPushed: (x, y) ->
		x =  x - this.X()
		y =  y - this.Y()
		console.log(this.X() + ' ' + this.Y())
		console.log(x + ' ' + y)
		direction = "none"
		if x > 0 and x < 48 and y > 24 and y < 72
			direction = "left"
		else if x > 48 and x < 96 and y > 24 and y < 72
			direction = "right"
		else if x > 24 and x < 72 and y > 0 and y < 48
			direction = "up"
		else if x > 24 and x < 72 and y > 48 and y < 96
			direction = "down"
		return direction
class Alien extends GridEntity
	constructor: (map, x, y) ->
		super('resources/ghost.png', map, 'x', x, y)
		@asleep = false
		
		xc.addEventListener('MonsterTick', this)

	move: ->
		x = @map.man.gridX - @gridX
		y = @map.man.gridY - @gridY
		
		if x > 0 
			x = 1 
		else if x < 0
			x = -1
		if y > 0 
			y = 1 
		else if y < 0  
			y = -1
		
		orderedMoves = this.getOrderedMoves(x, y)
		moved = false
		for move in orderedMoves
			x = move[0]
			y = move[1]
			
			if this.validMove(x, y)
				this.gridMove(x, y)
				moved = true
				@alseep = false
				if @gridX == @map.man.gridX and @gridY == @map.man.gridY
					@map.man.die()
				break
		
		if not moved and not @alseep
			xc.dispatchEvent(new XCEvent("MonsterSleep"))
			@asleep = true
		
	getOrderedMoves: (x, y) ->
		if (x == -1 and y == -1)
			moves = [[-1, -1], [-1, 0], [0, -1], [-1, 1], [1, -1], [0, 0]]
		else if x == 0 and y == -1 
			moves = [[0, -1], [1, -1], [-1, -1], [-1, 0], [1, 0], [0, 0]]
		else if x == 1 and y == -1 
			moves = [[1, -1], [1, 0], [0, -1], [1, 1], [-1, -1], [0, 0]]
		else if x == 1 and y == 0 
			moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]]
		else if x == -1 and y == 0 
			moves = [[-1, 0], [-1, 1], [-1, -1], [0, -1], [0, 1], [0, 0]]
		else if x == 1 and y == 0 
			moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]]
		else if x == -1 and y == 1 
			moves =  [[-1,1], [0,1], [-1,0], [1, 1], [-1, -1], [0, 0]]
		else if x == 0 and y == 1  
			moves = [[0, 1], [1, 1], [-1, 1], [-1, 0], [0, 1], [0, 0]]   
		else if x == 1 and y == 1 
			moves = [[1,1], [0,1], [1,0], [-1, 1], [1, -1], [0, 0]]
		else
			moves =  [[0, 0]]
		return moves
		
		
	validMove: (x, y) ->
		if @map.tiles[@gridX + x][@gridY + y] == "empty" or @map.tiles[@gridX + x][@gridY + y].type == "$"
			return true
		else
			return false
			
	MonsterTick: (event) ->
		console.log('Monster ' + @name + ' moving!')
		this.move()
		return false


class Map extends XCNode
	constructor: () ->
		super()
		this.loadMap()
		
	loadMap: ->
	
		map = []
		`
		map.width = 20
		map.height = 20
		map.tileSize = 16
		map.tiles= [
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			]
	`
		@width = map.width
		@height = map.height
		@gridSize = 16

		@tiles = new Array(@width)
		for i in [0 .. @width]
			@tiles[i] = new Array(@height)
			
		for x in [0 ... @width]
			for y in [0 ... @height]
				type = map.tiles[y][x]
				fileName = ""
				if type == "#"
					console.log('a wall')
					fileName = "resources/grave.png"
				else if type == "@"
					fileName = "resources/pumpkin.png"
				
				if fileName != ""
					console.log(x + ' ' + y)
					@tiles[x][y] = new GridEntity(fileName, this, type, x, y)
				else
					empty = []
					empty.type = "empty"
					@tiles[x][y] = "empty"
					
					
	moveableBlock: (block) ->  block.type != '#'
	
	getFreeSpace: ->
			x = Math.floor(Math.random() * @width)
			y = Math.floor(Math.random() * @height)
			console.log(x + ' ' + y)
			while @tiles[x][y] != 'empty'
				x = Math.floor(Math.random() * @width)
				y = Math.floor(Math.random() * @height)
				
			return {x: x, y: y}

class GridEntity extends XCSpriteNode
	constructor: (imageName, @map, @type, @gridX, @gridY) ->

		super(imageName, @map.gridSize, @map.gridSize)
		this.setX( @gridX * @map.gridSize)
		this.setY(@gridY * @map.gridSize)
		
		@map.addChild(this)
		
	gridMove: (x, y) ->
		@map.tiles[@gridX][@gridY] = "empty"
		@map.tiles[@gridX+x][@gridY+y] = this
		this.moveBy(x * @map.gridSize, y * @map.gridSize)
		this.gridX += x
		this.gridY += y

class Man extends GridEntity
	constructor: (map, x, y) ->
		super('resources/dude.png', map, "$", x, y)
		@direction = {'up': [-0,  -1], down: [0, 1], 'left': [-1, 0], 'right': [1,0]}
		@moveDirection = 'none'
		
		moveAction = new XCAction('ManMoveAction')
		moveAction.delay = 0
		moveAction.tick = (dt) ->
			@delay -= dt
			if @owner.moveDirection != 'none' and @delay <= 0
				if @owner.movedBlocks(@owner.moveDirection)
					@owner.gridMove(@owner.direction[@owner.moveDirection][0], @owner.direction[@owner.moveDirection][1])
					@delay = .2
		this.runAction(moveAction)

		xc.addEventListener('MoveEvent', this)
		
	movedBlocks: (direction) ->
		if direction == "left"
			this.horizontalMove(-1)
		else if direction == "right"
			this.horizontalMove(1)
		else if direction == "up"
			this.verticalMove(-1)
		else if direction == "down"
			this.verticalMove(1)
			
	horizontalMove: (direction) ->
		currentX = @gridX
		y = @gridY
		
		block = @map.tiles[currentX + direction][y]
		
		while block != "empty"
			if not @map.moveableBlock(block)
				return false
			else
				currentX += direction
				block = @map.tiles[currentX + direction][y]
				
		while (currentX < @gridX and direction == -1) or (currentX > @gridX and direction == 1)
			if @map.tiles[currentX + direction][y] != "empty"
				console.log("BAD LOGIC")
			@map.tiles[currentX][y].gridMove(direction, 0)
			currentX -= direction
			
		return true
		
	verticalMove: (direction) ->
		currentY = @gridY
		x = @gridX

		block = @map.tiles[x][currentY + direction]

		while block != "empty"
			if not @map.moveableBlock(block)
				return false
			else
				currentY += direction
				block = @map.tiles[x][currentY + direction]

		while (currentY < @gridY and direction == -1) or (currentY > @gridY and direction == 1)
			if @map.tiles[x][currentY + direction] != "empty"
				console.log("BAD LOGIC")
			@map.tiles[x][currentY].gridMove(0, direction)
			currentY -= direction

		return true
		
	die: ->
		xc.dispatchEvent(new XCEvent('ManDied'))
		newPos = @map.getFreeSpace()
		this.gridMove(newPos.x - @gridX, newPos.y - @gridY)

	MoveEvent: (event) ->
		this.moveDirection = event.direction
		

class LifeCounter extends XCNode
	constructor: (@lifeCount) ->
		super()
		@man = new XCSpriteNode('resources/dude.png', 16, 16)
		this.addChild(@man)
		@man.moveTo(10,352)
		
		lifeString = 'x' + @lifeCount
		@lifeCounter = new XCTextNode(lifeString, 'Helvetica', 12)
		
		this.addChild(@lifeCounter)
		@lifeCounter.moveTo(30, 365)
		
	addLife: ->
		@lifeCount += 1
		this.update()
		
	removeLife: ->
		@lifeCount -= 1
		this.update()
		if @lifeCount <= 0
			xc.dispatchEvent(new XCEvent('GameOver'))
		
		
	update: ->
		lifeString = 'x' + @lifeCount
		@lifeCounter.setText(lifeString)
		  
		
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
	
class DPad extends XCSpriteNode
	constructor: ->
		super('resources/dpad.png', 96, 96)
		xc.addEventListener('tapDown', this)

	tapDown: (event) ->
		x = event.x
		y = event.y

		if event.x > 320 - 96 and event.x < 320 and event.y > 384 and event.y < 480
			console.log('this tap belongs to me')

	directionPushed: (x, y) ->
		x =  x - this.X()
		y =  y - this.Y()
		console.log(this.X() + ' ' + this.Y())
		console.log(x + ' ' + y)
		direction = "none"
		if x > 0 and x < 48 and y > 24 and y < 72
			direction = "left"
		else if x > 48 and x < 96 and y > 24 and y < 72
			direction = "right"
		else if x > 24 and x < 72 and y > 0 and y < 48
			direction = "up"
		else if x > 24 and x < 72 and y > 48 and y < 96
			direction = "down"
		return direction
class Alien extends GridEntity
	constructor: (map, x, y) ->
		super('resources/ghost.png', map, 'x', x, y)
		@asleep = false
		
		xc.addEventListener('MonsterTick', this)

	move: ->
		x = @map.man.gridX - @gridX
		y = @map.man.gridY - @gridY
		
		if x > 0 
			x = 1 
		else if x < 0
			x = -1
		if y > 0 
			y = 1 
		else if y < 0  
			y = -1
		
		orderedMoves = this.getOrderedMoves(x, y)
		moved = false
		for move in orderedMoves
			x = move[0]
			y = move[1]
			
			if this.validMove(x, y)
				this.gridMove(x, y)
				moved = true
				@alseep = false
				if @gridX == @map.man.gridX and @gridY == @map.man.gridY
					@map.man.die()
				break
		
		if not moved and not @alseep
			xc.dispatchEvent(new XCEvent("MonsterSleep"))
			@asleep = true
		
	getOrderedMoves: (x, y) ->
		if (x == -1 and y == -1)
			moves = [[-1, -1], [-1, 0], [0, -1], [-1, 1], [1, -1], [0, 0]]
		else if x == 0 and y == -1 
			moves = [[0, -1], [1, -1], [-1, -1], [-1, 0], [1, 0], [0, 0]]
		else if x == 1 and y == -1 
			moves = [[1, -1], [1, 0], [0, -1], [1, 1], [-1, -1], [0, 0]]
		else if x == 1 and y == 0 
			moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]]
		else if x == -1 and y == 0 
			moves = [[-1, 0], [-1, 1], [-1, -1], [0, -1], [0, 1], [0, 0]]
		else if x == 1 and y == 0 
			moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]]
		else if x == -1 and y == 1 
			moves =  [[-1,1], [0,1], [-1,0], [1, 1], [-1, -1], [0, 0]]
		else if x == 0 and y == 1  
			moves = [[0, 1], [1, 1], [-1, 1], [-1, 0], [0, 1], [0, 0]]   
		else if x == 1 and y == 1 
			moves = [[1,1], [0,1], [1,0], [-1, 1], [1, -1], [0, 0]]
		else
			moves =  [[0, 0]]
		return moves
		
		
	validMove: (x, y) ->
		if @map.tiles[@gridX + x][@gridY + y] == "empty" or @map.tiles[@gridX + x][@gridY + y].type == "$"
			return true
		else
			return false
			
	MonsterTick: (event) ->
		console.log('Monster ' + @name + ' moving!')
		this.move()
		return false


class Map extends XCNode
	constructor: () ->
		super()
		this.loadMap()
		
	loadMap: ->
	
		map = []
		`
		map.width = 20
		map.height = 20
		map.tileSize = 16
		map.tiles= [
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			]
	`
		@width = map.width
		@height = map.height
		@gridSize = 16

		@tiles = new Array(@width)
		for i in [0 .. @width]
			@tiles[i] = new Array(@height)
			
		for x in [0 ... @width]
			for y in [0 ... @height]
				type = map.tiles[y][x]
				fileName = ""
				if type == "#"
					console.log('a wall')
					fileName = "resources/grave.png"
				else if type == "@"
					fileName = "resources/pumpkin.png"
				
				if fileName != ""
					console.log(x + ' ' + y)
					@tiles[x][y] = new GridEntity(fileName, this, type, x, y)
				else
					empty = []
					empty.type = "empty"
					@tiles[x][y] = "empty"
					
					
	moveableBlock: (block) ->  block.type != '#'
	
	getFreeSpace: ->
			x = Math.floor(Math.random() * @width)
			y = Math.floor(Math.random() * @height)
			console.log(x + ' ' + y)
			while @tiles[x][y] != 'empty'
				x = Math.floor(Math.random() * @width)
				y = Math.floor(Math.random() * @height)
				
			return {x: x, y: y}

class GridEntity extends XCSpriteNode
	constructor: (imageName, @map, @type, @gridX, @gridY) ->

		super(imageName, @map.gridSize, @map.gridSize)
		this.setX( @gridX * @map.gridSize)
		this.setY(@gridY * @map.gridSize)
		
		@map.addChild(this)
		
	gridMove: (x, y) ->
		@map.tiles[@gridX][@gridY] = "empty"
		@map.tiles[@gridX+x][@gridY+y] = this
		this.moveBy(x * @map.gridSize, y * @map.gridSize)
		this.gridX += x
		this.gridY += y

class Man extends GridEntity
	constructor: (map, x, y) ->
		super('resources/dude.png', map, "$", x, y)
		@direction = {'up': [-0,  -1], down: [0, 1], 'left': [-1, 0], 'right': [1,0]}
		@moveDirection = 'none'
		
		moveAction = new XCAction('ManMoveAction')
		moveAction.delay = 0
		moveAction.tick = (dt) ->
			@delay -= dt
			if @owner.moveDirection != 'none' and @delay <= 0
				if @owner.movedBlocks(@owner.moveDirection)
					@owner.gridMove(@owner.direction[@owner.moveDirection][0], @owner.direction[@owner.moveDirection][1])
					@delay = .2
		this.runAction(moveAction)

		xc.addEventListener('MoveEvent', this)
		
	movedBlocks: (direction) ->
		if direction == "left"
			this.horizontalMove(-1)
		else if direction == "right"
			this.horizontalMove(1)
		else if direction == "up"
			this.verticalMove(-1)
		else if direction == "down"
			this.verticalMove(1)
			
	horizontalMove: (direction) ->
		currentX = @gridX
		y = @gridY
		
		block = @map.tiles[currentX + direction][y]
		
		while block != "empty"
			if not @map.moveableBlock(block)
				return false
			else
				currentX += direction
				block = @map.tiles[currentX + direction][y]
				
		while (currentX < @gridX and direction == -1) or (currentX > @gridX and direction == 1)
			if @map.tiles[currentX + direction][y] != "empty"
				console.log("BAD LOGIC")
			@map.tiles[currentX][y].gridMove(direction, 0)
			currentX -= direction
			
		return true
		
	verticalMove: (direction) ->
		currentY = @gridY
		x = @gridX

		block = @map.tiles[x][currentY + direction]

		while block != "empty"
			if not @map.moveableBlock(block)
				return false
			else
				currentY += direction
				block = @map.tiles[x][currentY + direction]

		while (currentY < @gridY and direction == -1) or (currentY > @gridY and direction == 1)
			if @map.tiles[x][currentY + direction] != "empty"
				console.log("BAD LOGIC")
			@map.tiles[x][currentY].gridMove(0, direction)
			currentY -= direction

		return true
		
	die: ->
		xc.dispatchEvent(new XCEvent('ManDied'))
		newPos = @map.getFreeSpace()
		this.gridMove(newPos.x - @gridX, newPos.y - @gridY)

	MoveEvent: (event) ->
		this.moveDirection = event.direction
		

class LifeCounter extends XCNode
	constructor: (@lifeCount) ->
		super()
		@man = new XCSpriteNode('resources/dude.png', 16, 16)
		this.addChild(@man)
		@man.moveTo(10,352)
		
		lifeString = 'x' + @lifeCount
		@lifeCounter = new XCTextNode(lifeString, 'Helvetica', 12)
		
		this.addChild(@lifeCounter)
		@lifeCounter.moveTo(30, 365)
		
	addLife: ->
		@lifeCount += 1
		this.update()
		
	removeLife: ->
		@lifeCount -= 1
		this.update()
		if @lifeCount <= 0
			xc.dispatchEvent(new XCEvent('GameOver'))
		
		
	update: ->
		lifeString = 'x' + @lifeCount
		@lifeCounter.setText(lifeString)
		  
		
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
	
class DPad extends XCSpriteNode
	constructor: ->
		super('resources/dpad.png', 96, 96)
		xc.addEventListener('tapDown', this)

	tapDown: (event) ->
		x = event.x
		y = event.y

		if event.x > 320 - 96 and event.x < 320 and event.y > 384 and event.y < 480
			console.log('this tap belongs to me')

	directionPushed: (x, y) ->
		x =  x - this.X()
		y =  y - this.Y()
		console.log(this.X() + ' ' + this.Y())
		console.log(x + ' ' + y)
		direction = "none"
		if x > 0 and x < 48 and y > 24 and y < 72
			direction = "left"
		else if x > 48 and x < 96 and y > 24 and y < 72
			direction = "right"
		else if x > 24 and x < 72 and y > 0 and y < 48
			direction = "up"
		else if x > 24 and x < 72 and y > 48 and y < 96
			direction = "down"
		return direction
class Alien extends GridEntity
	constructor: (map, x, y) ->
		super('resources/ghost.png', map, 'x', x, y)
		@asleep = false
		
		xc.addEventListener('MonsterTick', this)

	move: ->
		x = @map.man.gridX - @gridX
		y = @map.man.gridY - @gridY
		
		if x > 0 
			x = 1 
		else if x < 0
			x = -1
		if y > 0 
			y = 1 
		else if y < 0  
			y = -1
		
		orderedMoves = this.getOrderedMoves(x, y)
		moved = false
		for move in orderedMoves
			x = move[0]
			y = move[1]
			
			if this.validMove(x, y)
				this.gridMove(x, y)
				moved = true
				@alseep = false
				if @gridX == @map.man.gridX and @gridY == @map.man.gridY
					@map.man.die()
				break
		
		if not moved and not @alseep
			xc.dispatchEvent(new XCEvent("MonsterSleep"))
			@asleep = true
		
	getOrderedMoves: (x, y) ->
		if (x == -1 and y == -1)
			moves = [[-1, -1], [-1, 0], [0, -1], [-1, 1], [1, -1], [0, 0]]
		else if x == 0 and y == -1 
			moves = [[0, -1], [1, -1], [-1, -1], [-1, 0], [1, 0], [0, 0]]
		else if x == 1 and y == -1 
			moves = [[1, -1], [1, 0], [0, -1], [1, 1], [-1, -1], [0, 0]]
		else if x == 1 and y == 0 
			moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]]
		else if x == -1 and y == 0 
			moves = [[-1, 0], [-1, 1], [-1, -1], [0, -1], [0, 1], [0, 0]]
		else if x == 1 and y == 0 
			moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]]
		else if x == -1 and y == 1 
			moves =  [[-1,1], [0,1], [-1,0], [1, 1], [-1, -1], [0, 0]]
		else if x == 0 and y == 1  
			moves = [[0, 1], [1, 1], [-1, 1], [-1, 0], [0, 1], [0, 0]]   
		else if x == 1 and y == 1 
			moves = [[1,1], [0,1], [1,0], [-1, 1], [1, -1], [0, 0]]
		else
			moves =  [[0, 0]]
		return moves
		
		
	validMove: (x, y) ->
		if @map.tiles[@gridX + x][@gridY + y] == "empty" or @map.tiles[@gridX + x][@gridY + y].type == "$"
			return true
		else
			return false
			
	MonsterTick: (event) ->
		console.log('Monster ' + @name + ' moving!')
		this.move()
		return false

