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
		@index = -1

	update: (delta) ->
		this.onUpdate(delta)
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
		child.index = @children.length
		child.parent = this

	removeChild: (child) ->
		@children = @children[0...child.index].concat(@children[child.index...@children.length])
		child.index = -1
		child.parent = null

class XCSpriteNode extends XCNode
	constructor: (imageName, @width, @height) ->
		@drawable = true
		super()
		@sprite = xc.loadSprite(imageName)
		console.log('loaded sprite')
		@frame = 0

	draw: (context) ->
		console.log('drawing a sprite')
		context.save()
		
		context.translate(@x - (@x * @anchorX), @y - (@x * @anchorY))
		
		context.rotate(@rotation * Math.PI / 180)

		context.drawImage(@sprite, 0, 0, @width, @height, 0, 0, @width * @scaleX, @height * @scaleY)

		context.restore()
		

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
		context.fillText(@text, @x, @y)
	
