class DPad extends XCSpriteNode
	constructor: ->
		super('dpad.png', 96, 96)
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
