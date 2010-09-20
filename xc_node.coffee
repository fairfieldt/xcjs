class XCNode
	constructor: ()  ->
		@visible = true
		@x = 0
		@y = 0
		@scaleX = 1.0
		@scaleY = 1.0
		@rotation = 0.0
		@anchorX = 0.0
		@anchorY = 0.0
		@parent = null
		@children = new Array() 

		@actions = []

	update: (delta) ->
		this.onUpdate(delta)
		for action in @actions
			action.tick(delta)
		for child in @children
			child.update(delta)

	onUpdate: ->

	moveBy: (xOffset, yOffset) ->
		@x += xOffset
		@y += yOffset

	moveTo: (xPosition, yPosition) ->
		@x = xPosition
		@y = yPosition

	scaleXBy: (factor) ->
		@scaleX = @scaleX * factor

	scaleXTo: (newScale) ->
		@scaleX = newScale

	scaleYBy: (factor) ->
		@scaleY = @scaleY * factor

	scaleYTo: (newScale) ->
		@scaleY = newScale

	scaleBy: (factor) ->
		@scaleX = @scaleX * factor
		@scaleY = @scaleY * factor

	scaleTo: (newScale) ->
		@scaleX = newScale
		@scaleY = newScale
		

	rotateBy: (offset) ->
		@rotation = @rotation + offset

	rotateTo: (newRotation) ->
		@rotation = newRotation

	setAnchorX: (anchor) ->
		@anchorX = anchor

	setAnchorY: (anchor) ->
		@anchorY = anchor

	addChild: (child) ->
		@children.push(child)
		child.parent = this

	removeChild: (child) ->
		pos = @children.indexOf(child)
		if pos != -1
			@children = @children[0...pos].concat(@children[pos+1...@children.length])
			child.parent = null

	runAction: (action) ->
		action.owner = this
		@actions.push(action)

	removeAction: (action) ->
		pos = @actions.indexOf(action)
		if pos != -1
			@actions = @actions[0...pos].concat(@actions[pos+1...@actions.length]) 


class XCSpriteNode extends XCNode
	constructor: (imageName, @width, @height) ->
		@drawable = true
		super()
		@sprite = xc.loadSprite(imageName)
		@frame = 0

	draw: (context) ->
		context.translate(@x - (@x * @anchorX), @y - (@x * @anchorY))
		
		context.rotate(@rotation * Math.PI / 180)

		context.drawImage(@sprite, 0, 0, @width, @height, 0, 0, @width * @scaleX, @height * @scaleY)

class XCScene extends XCNode
	constructor: ->
		super()

	close: ->


class XCTextNode extends XCNode
	constructor: (@text, @font) ->
		@drawable = true
		super()
		
	draw: (context) ->
		context.font = @font

		context.translate(@x - (@x * @anchorX), @y - (@x * @anchorY))
		context.rotate(@rotation * Math.PI / 180)

		context.fillText(@text, 0, 0)

	
