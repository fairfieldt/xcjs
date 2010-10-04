class DPad extends XCSpriteNode
	constructor: ->
		super('dpad.png', 96, 96)
		xc.addEventListener('tapDown', this)
		
	tapDown: (event) ->
			x = event.x
			y = event.y
			
			if event.x > 320 - 96 and event.x < 320 and event.y > 384 and event.y < 480
				console.log('this tap belongs to me')
	