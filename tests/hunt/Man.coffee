class Man extends GridEntity
	constructor: (map, x, y) ->
		super('resources/dude.png', map, "$", x, y)
		@direction = {'up': [-0,  -1], down: [0, 1], 'left': [-1, 0], 'right': [1,0]}
		@moveDirection = 'none'
		
		moveAction = new XCAction('ManMoveAction')
		moveAction.delay = 0
		moveAction.tick = (dt) ->
			@delay -= dt
			if @owner.moveDir != 'none' and @delay <= 0
				if @owner.movedBlocks(@owner.moveDirection)
					@owner.gridMove(@owner.direction[@owner.moveDirection][0], @owner.direction[@owner.moveDirection][1])
					@delay = .2
		this.runAction(moveAction)

		xc.addEventListener('moveEvent', this)
		
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
		console.log('I died')
		this.gridMove(1-@gridX, 1-@gridY)

	moveEvent: (event) ->
		direction = this.tapLocation(event.x, event.y)
		console.log('a move event!')
		if direction == "left"
			if this.movedBlocks("left")
				this.gridMove(-1, 0)
		else if direction == "right"
			if this.movedBlocks("right")
				this.gridMove(1, 0)
		else if direction == "up"
			if this.movedBlocks("up")
				this.gridMove(0, -1)
		else if direction == "down"
			if this.movedBlocks("down")
				this.gridMove(0, 1)
