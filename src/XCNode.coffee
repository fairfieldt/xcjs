#################################################################
# XCNode is the base for most objects in an xc application.
# XCNodes have xy positions, scale, rotation, opacity, and color.
# For drawable nodes these will affect their appearance on screen.
# They also have x and y anchor points which effect things such
# as rotation.
# ###############################################################

class XCNode
	constructor: ->
		@visible = true
		@_x = 0
		@_y = 0
		@_layer = 0
		@_scaleX = 1.0
		@_scaleY = 1.0
		@_rotation = 0.0
		@_opacity = 1.0
		@_anchorX = 0.0
		@_anchorY = 0.0
		#this.setAnchorX(0.0)
		#this.setAnchorY(0.0)
		@parent = null
		@_color = new XCColor(0, 0, 0)
		@children = new Array() 

	moveBy: (xOffset, yOffset) ->
		this.setX(this.X() + xOffset)
		this.setY(this.Y() + yOffset)

	moveTo: (xPosition, yPosition) ->
		this.setX(xPosition)
		this.setY(yPosition)
		
	X: ->
		return _xcNodeX(this)
	Y: ->
		return _xcNodeY(this)
		
	layer: -> return _xcNodeLayer(this)
	
	setLayer: -> return _xcNodeSetLayer(this)

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

	anchorX: ->
		_xcNodeAnchorX(this)
	
	anchorY: ->
		_xcNodeAnchorY(this)

	setAnchorX: (newAnchorX) ->
		_xcNodeSetAnchorX(this, newAnchorX)

	setAnchorY: (newAnchorY) ->
		_xcNodeSetAnchorY(this, newAnchorY)

	visible: ->
		_xcNodeVisbile(this)
		
	hide: ->
		_xcNodeSetVisible(this, false)
	
	show: ->
		_xcNodeSetVisible(this, true)

	runAction: (action) ->
		action.owner = this
		xc.actions.push(action)

	removeAction: (action) ->
		pos = xc.actions.indexOf(action)
		if pos != -1
			xc.actions = xc.actions[0...pos].concat(xc.actions[pos+1...xc.actions.length]) 
