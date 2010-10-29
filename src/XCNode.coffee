#################################################################
# XCNode is the base for most objects in an xc application.
# XCNodes have xy positions, scale, rotation, opacity, and color.
# For drawable nodes these will affect their appearance on screen.
# They also have x and y anchor points which effect things such
# as rotation.
# ###############################################################

#=require XCColor

class XCNode
	constructor: ->
		@_visible = true
		@_x = 0
		@_y = 0
		@_layer = 0
		@_scaleX = 1.0
		@_scaleY = 1.0
		@_rotation = 0.0
		@_opacity = 1.0
		@_anchorX = .5
		@_anchorY = .5
		#this.setAnchorX(0.0)
		#this.setAnchorY(0.0)
		@parent = null
		@_color = new XCColor(0, 0, 0)
		@_actions = []
		

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

	setX: (newX) ->
		_xcNodeSetX(this, newX)
	
	setY: (newY) ->
		_xcNodeSetY(this, newY)
			
	layer: -> return _xcNodeLayer(this)
	
	setLayer: (newLayer) ->  _xcNodeSetLayer(this, newLayer)

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
		_xcNodeVisible(this)
		
	hide: ->
		_xcNodeSetVisible(this, false)
	
	show: ->
		_xcNodeSetVisible(this, true)

	actions: ->  @_actions
	
	runAction: (action) ->
		if @_actions.indexOf(action) == -1 and action.owner == null
			action.owner = this
			@_actions.push(action)
		else
			throw {name:"RunDuplicateActionError", message:"Tried to add action " + action + " to " + this + " twice"}

	removeAction: (action) ->
		pos = @_actions.indexOf(action)
		if pos != -1
			@_actions = @_actions[0...pos].concat(@_actions[pos+1...@_actions.length]) 
		else
			throw {name:"RemoveActionError", message:"Tried to remove action " + action.name + " when it was not added"}
