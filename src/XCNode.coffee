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
		# these underscore prefixed variables are specific
		# to the canvas implementation.  they should never be
		# read from or assigned to.  I might eventually make them
		# private or move them elsewhere.
		@_visible = true
		@_x = 0
		@_y = 0
		@_layer = 0
		@_scaleX = 1.0
		@_scaleY = 1.0
		@_rotation = 0.0
		@_opacity = 1.0
		@_anchorX = 0
		@_anchorY = 0

		
		@parent = null
		@_color = new XCColor(0, 0, 0)
		@_actions = []
		
		#nodes should start with their anchor at 0,0
		this.setAnchorX(0.0)
		this.setAnchorY(0.0)
	
	#getters for width and height
	# they call the implementation specific _xc methods	
	width: -> _xcNodeWidth(this)
	height: -> _xcNodeHeight(this)
	
	# getter for a collision rect.  returns a rectangle
	# in the form of {x,y,w,h} where w and h are the width
	# and height of the rectangle.  TODO: make it work with rotation
	rect: ->
		{x:this.X() - (this.anchorX() * this.width()), y:this.Y() - (this.anchorY() * this.height()), w:this.width(), h:this.height()}

	# moves the node by x,y relative to its current position.
	moveBy: (xOffset, yOffset) ->
		this.setX(this.X() + xOffset)
		this.setY(this.Y() + yOffset)

	# moves the node to an absolute x,y position.
	moveTo: (xPosition, yPosition) ->
		this.setX(xPosition)
		this.setY(yPosition)
	
	#getters for the node's x and y position	
	#they call the implementation specific _xc functions
	X: -> _xcNodeX(this)
	Y: -> _xcNodeY(this)

	#setters for the node's x and y position
	#they call the implementation specific _xc functions
	setX: (newX) ->
		_xcNodeSetX(this, newX)
	
	setY: (newY) ->
		_xcNodeSetY(this, newY)
	
	#getter and setter for the node's layer. The layer is a 
	#number.  The layer determines drawing
	# position, with higher layers drawn on top.  Calls the
	# implementation specific _xc function.
	layer: -> return _xcNodeLayer(this)
	
	setLayer: (newLayer) ->  _xcNodeSetLayer(this, newLayer)

	#getter and setter for the node's color.  The
	# color is an XCColor object.  They call the _xc
	# implementation specific functions.  
	color: ->
		_xcNodeColor(this)
	
	setColor: (newColor) ->
		_xcNodeSetColor(this, newColor)

	# scales the node in the X dimension
	# (multiplicative) by a factor >= 0
	scaleXBy: (factor) ->
		this.setScaleX(this.scaleX() * factor)

	#scales the node to a new scale in the x dimension
	#scales must be >= 0
	scaleXTo: (newScale) ->
		this.setScaleX(newScale)	

	#setter for node's scaleX.  calls the implementation
	# specific _xc function
	setScaleX: (newScaleX) ->
		_xcNodeSetScaleX(this, newScaleX)

	#scales the node in the Y dimension
	# (multiplicative) by a factor >= 0
	scaleYBy: (factor) ->
		this.setScaleY(this.scaleY() * factor)
	
	#scales the node in the y dimension to a news
	#scale >= 0
	scaleYTo: (newScale) ->
		this.setScaleY(newScale)

	#setter for the node's y scale. calls the
	# implementation specific _xc function.
	setScaleY: (newScaleY) ->
		_xcNodeSetScaleY(this, newScaleY)

	#scales the node in both the x and y dimensions
	# (multiplicative) by a factor >= 0
	scaleBy: (factor) ->
		this.setScaleX(this.scaleX() * factor)
		this.setScaleY(this.scaleY() * factor)

	#scales the node in both the x and y dimensions
	# to a new scale >= 0
	scaleTo: (newScale) ->
		this.setScaleX(newScale)
		this.setScaleY(newScale)
	
	#getters for node's x and yscale. uses the
	# implementation specific _xc methods	
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
	
	tick: (dt) ->
		for action in this.actions()
			if not action.tick(dt)
				this.removeAction(action)
				
	runAction: (action) ->
		if @_actions.indexOf(action) == -1 and action.owner == null
			action.setOwner(this)
			@_actions.push(action)
		else
			throw {name:"RunDuplicateActionError", message:"Tried to add action " + action + " to " + this + " twice"}

	removeAction: (action) ->
		pos = @_actions.indexOf(action)
		if pos != -1
			@_actions = @_actions[0...pos].concat(@_actions[pos+1...@_actions.length]) 
		else
			throw {name:"RemoveActionError", message:"Tried to remove action " + action.name + " when it was not added"}
