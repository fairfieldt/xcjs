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
		this.setAnchorX(0.0)
		this.setAnchorY(0.0)
		@parent = null
		@_color = new XCColor(0, 0, 0)
		@children = new Array() 

	moveBy: (xOffset, yOffset) ->
		this.setX(this.X() + xOffset)
		this.setY(this.Y() + yOffset)

	moveTo: (xPosition, yPosition) ->
		console.log('and now x is ' + this.X())
		this.setX(xPosition)
		this.setY(yPosition)
		console.log('and now x is ' + this.X())
		
		
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
		this.setScaleX(this.scaleX() * factor)

	scaleXTo: (newScale) ->
		this.setScaleX(newScale)	

	setScaleX: (newScaleX) ->
		_xcNodeSetScaleX(this, newScaleX)

	scaleYBy: (factor) ->
		this.setScaleY(this.scaleY() * factor)

	scaleYTo: (newScale) ->
		this.setScaleY(newScale)

	setScaleY: (newScaleY) ->
		_xcNodeSetScaleY(this, newScaleY)

	scaleBy: (factor) ->
		this.setScaleX(this.scaleX() * factor)
		this.setScaleY(this.scaleY() * factor)

	scaleTo: (newScale) ->
		this.setScaleX(newScale)
		this.setScaleY(newScale)
		
	scaleX: ->
		_xcNodeScaleX(this)		

	scaleY: ->
		_xcNodeScaleY(this)
		
	rotateBy: (offset) ->
		this.setRotation(this.rotation() + offset)

	rotateTo: (newRotation) ->
		this.setRotation(newRotation)
	
	rotation: ->
		_xcNodeRotation(this)

	setRotation: (newRotation) ->
		_xcNodeSetRotation(this, newRotation)
		
	fadeTo: (newOpacity) ->
		this.setOpacity(newOpacity)

	fadeBy: (opacity) ->
		this.setOpacity(Math.max(this.opacity-opacity, 0))

	opacity: -> _xcNodeOpacity(this)

	setOpacity: (newOpacity) ->
		_xcNodeSetOpacity(this, newOpacity)

	setAnchorX: (anchor) ->
		this.setAnchorX(anchor)

	setAnchorY: (anchor) ->
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
		_xcTextSetText(this, newText)		
		
	draw: ->
		_xcTextDraw(this)

class XCLayer extends XCNode
	constructor: ->
		super()
		
	
	
