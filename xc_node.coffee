class XCNode
	constructor: ()  ->
		@visible = true
		@x = 0
		@y = 0
		@z = 0
		@scaleX = 1.0
		@scaleY = 1.0
		@rotation = 0.0
		@opacity = 1.0
		@anchorX = 0.0
		@anchorY = 0.0
		@parent = null
		@color = new XCColor(0, 0, 0)
		@children = new Array() 
		@dirty = true
		@actions = []

	update: (delta) ->
		this.onUpdate(delta)
		for action in @actions
			action.tick(delta)
		for child in @children
			child.update(delta)

	onUpdate: ->

	moveBy: (xOffset, yOffset) ->
		@dirty = true
		@x += xOffset
		@y += yOffset

	moveTo: (xPosition, yPosition) ->
		@dirty = true
		@x = xPosition
		@y = yPosition
		
	x: ->
		_xcNodeX(this)
	y: ->
		_xcNodeY(this)
		
	color: ->
		_xcNodeColor(this)

	scaleXBy: (factor) ->
		@dirty = true
		@scaleX = @scaleX * factor

	scaleXTo: (newScale) ->
		@dirty = true
		@scaleX = newScale

	scaleYBy: (factor) ->
		@dirty = true
		@scaleY = @scaleY * factor

	scaleYTo: (newScale) ->
		@dirty = true
		@scaleY = newScale

	scaleBy: (factor) ->
		@dirty = true
		@scaleX = @scaleX * factor
		@scaleY = @scaleY * factor

	scaleTo: (newScale) ->
		@dirty = true
		@scaleX = newScale
		@scaleY = newScale
		
	scaleX: ->
		_xcNodeScaleX(this)		

	scaleY: ->
		_xcNodeScaleY(this)
		
	rotateBy: (offset) ->
		@dirty = true
		@rotation = @rotation + offset

	rotateTo: (newRotation) ->
		@dirty = true
		@rotation = newRotation
	
	rotation: ->
		_xcNodeRotation(this)
		
	fadeTo: (newOpacity) ->
		@dirty = true
		@opacity = newOpacity
	
	fadeBy: (opacity) ->
		@dirty = true
		@opacity = Math.max(@opacity + newOpacity, 0)
		
	opacity: -> _xcNodeOpacity(this)

	setAnchorX: (anchor) ->
		@dirty = true
		@anchorX = anchor

	setAnchorY: (anchor) ->
		@dirty = true
		@anchorY = anchor
		
	anchorX: ->
		_xcNodeAnchorX(this)
	
	anchorY: ->
		_xcNodeAnchorY(this)

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
		@sprite = _xcLoadSprite(imageName)
		@frame = 0

	draw: ->
		_xcSpriteDraw(this)
		@dirty = false
		
class XCScene extends XCNode
	constructor: ->
		super()

	close: ->


class XCTextNode extends XCNode
	constructor: (@text, @fontName, @fontSize) ->
		@drawable = true
		
		@ref = _xcLoadText(this)
		
		super()

	setText: (newText) ->
		@dirty = true
		@text = newText
		
		
	draw: ->
		_xcTextDraw(this)
		@dirty = false 

class XCLayer extends XCNode
	constructor: ->
		super()
		
	
	
