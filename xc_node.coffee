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
		@children = []
		@index = -1

	update: (delta) ->
		this.onUpdate(delta)
		for child in @children
			child.update(delta)

	onUpdate: ->

	moveBy: (xOffset, yOffset) ->
		@x += xOffset
		@y += yOffset
		@sprite.SetPosition(@x, @y)

	moveTo: (xPosition, yPosition) ->
		@x = xPosition
		@y = yPosition
		@sprite.SetPosition(@x, @y)

	scaleXBy: (factor) ->
		@scaleX = @scaleX * factor
		@sprite.xScale = @scaleX

	scaleXTo: (newScale) ->
		@scaleX = newScale
		@sprite.xScale = @scaleX

	scaleYBy: (factor) ->
		@scaleY = @scaleY * factor
		@sprite.yScale = @scaleY

	scaleYTo: (newScale) ->
		@scaleY = newScale
		@sprite.yScale = @scaleY

	scaleBy: (factor) ->
		@scaleX = @scaleX * factor
		@scaleY = @scaleY * factor
		@sprite.xScale = @scaleX
		@sprite.yScale = @scaleY

	scaleTo: (newScale) ->
		@scaleX = newScale
		@scaleY = newScale
		@sprite.xScale = @scaleX
		@sprite.yScale = @scaleY
		

	rotateBy: (offset) ->
		@rotation = @rotation + offset
		@sprite.rotation = @rotation

	rotateTo: (newRotation) ->
		@rotation = newRotation
		@sprite.rotation = @rotation

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
		super()
		@sprite = xc.loadSprite(imageName, @width, @height, 1, 1)
		@frame = 0
		

class XCScene extends XCNode
	constructor: ->

	close: ->


