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
		@rotation = rotation + offset

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
	constructor: (imageName) ->
		super()
		@sprite = xc.loadSprite(imageName)
		@width =  xc.getSpriteWidth(@sprite)
		@height = xc.getSpriteHeight(@sprite)

