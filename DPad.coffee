# 96/2 = 48/2 = 24

class DPad extends XCSpriteNode
	constructor: ->
		super('dpad.png', 96, 96)
		xc.addEventListener('tapDown', this)
		

	tapLocation: (x, y) ->
		x = x - this.X()
		y = y - this.Y()
		direction = 'none'
		console.log(x + ' ' + y)
		if x > 24 and x < 72 and y > 0 and y < 24
			direction = 'up'
		else if x > 24 and x < 72 and y > 72 and y < 96
			direction = 'down'
		else if x > 0 and x < 24 and y > 24 and y < 72
			direction = 'left'
		else if x > 72 and x < 96 and y > 24 and y < 72
			direction = 'right'
		return direction
