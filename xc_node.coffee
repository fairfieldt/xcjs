class XCNode
	constructor: ()  ->
		@visible = true
		@_x = 0
		@_y = 0
		@_z = 0
		@_scaleX = 1.0
		@_scaleY = 1.0
		@_rotation = 0.0
		@_opacity = 1.0
		@_anchorX = 0.0
		@_anchorY = 0.0
		@parent = null
		@_color = new XCColor(0, 0, 0)
		@children = new Array() 
		@dirty = true

	moveBy: (xOffset, yOffset) ->
		@dirty = true
		this.setX(this.X() + xOffset)
		this.setY(this.Y() + yOffset)

	moveTo: (xPosition, yPosition) ->
		@dirty = true
		this.setX(xPosition)
		this.setY(yPosition)
		
	X: ->
		return _xcNodeX(this)
	Y: ->
		return _xcNodeY(this)

	setX: (newX) ->
		_xcNodeSetX(this, newX)
	
	setY: (newY) ->
		_xcNodeSetY(this, newY)
		
	color: ->
		_xcNodeColor(this)
	
	setColor: (newColor) ->
		_xcNodeSetColor(this, newColor)

	scaleXBy: (factor) ->
		@dirty = true
		this.setScaleX(this.scaleX() * factor)

	scaleXTo: (newScale) ->
		@dirty = true
		this.setScaleX(newScale)	

	setScaleX: (newScaleX) ->
		_xcNodeSetScaleX(this, newScaleX)

	scaleYBy: (factor) ->
		@dirty = true
		this.setScaleY(this.scaleY() * factor)

	scaleYTo: (newScale) ->
		@dirty = true
		this.setScaleY(newScale)

	setScaleY: (newScaleY) ->
		_xcNodeSetScaleY(this, newScaleY)

	scaleBy: (factor) ->
		@dirty = true
		this.setScaleX(this.scaleX() * factor)
		this.setScaleY(this.scaleY() * factor)

	scaleTo: (newScale) ->
		@dirty = true
		this.setScaleX(newScale)
		this.setScaleY(newScale)
		
	scaleX: ->
		_xcNodeScaleX(this)		

	scaleY: ->
		_xcNodeScaleY(this)
		
	rotateBy: (offset) ->
		@dirty = true
		this.setRotation(this.rotation() + offset)

	rotateTo: (newRotation) ->
		@dirty = true
		this.setRotation(newRotation)
	
	rotation: ->
		_xcNodeRotation(this)

	setRotation: (newRotation) ->
		_xcNodeSetRotation(this, newRotation)
		
	fadeTo: (newOpacity) ->
		@dirty = true
		this.setOpacity(newOpacity)

	fadeBy: (opacity) ->
		@dirty = true
		this.setOpacity(Math.max(this.opacity-opacity, 0))

	opacity: -> _xcNodeOpacity(this)

	setOpacity: (newOpacity) ->
		_xcNodeSetOpacity(this, newOpacity)

	setAnchorX: (anchor) ->
		@dirty = true
		this.setAnchorX(anchor)

	setAnchorY: (anchor) ->
		@dirty = true
		this.setAnchorY(anchor)

	anchorX: ->
		_xcNodeAnchorX(this)
	
	anchorY: ->
		_xcNodeAnchorY(this)

	setAnchorX: (newAnchorX) ->
		_xcNodeSetAnchorX(this, newAnchorX)

	setAnchorY: (newAnchorY) ->
		_xcNodeSetAnchorY(this, newAnchorY)

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
		xc.actions.push(action)

	removeAction: (action) ->
		pos = xc.actions.indexOf(action)
		if pos != -1
			xc.actions = xc.actions[0...pos].concat(xc.actions[pos+1...xc.actions.length]) 


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
		_xcTextSetText(this, newText)		
		
	draw: ->
		_xcTextDraw(this)
		@dirty = false 

class XCLayer extends XCNode
	constructor: ->
		super()
		
	
	
