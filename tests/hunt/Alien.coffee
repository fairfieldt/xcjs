class Alien extends GridEntity
	constructor: (map, x, y) ->
		super('ghost.png', map, 'x', x, y)
		@asleep = false
		moveAction = XCAction("AlienMoveAction")
		moveAction.et = 0
		moveAction.tick = (dt) ->
			@et += dt
			if @et > 1.0
				@owner.move()
				@et = 0
		this.runAction(moveAction)
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
			console.log('asleep')
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
