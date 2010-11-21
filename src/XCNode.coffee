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

		
		@_parent = null
		@_color = new XCColor(0, 0, 0)
		@_actions = []
		
		#nodes should start with their anchor at .5,.5
		this.setAnchorX(0.5)
		this.setAnchorY(0.5)
	
	#getter and setter for the node's parent
	# scene is an XCScene	
	parent: -> @_parent
	setParent: (scene) -> @_parent = scene
	
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
	
	#rotate the node by offset, in degrees	
	rotateBy: (offset) ->
		this.setRotation(this.rotation() + offset)

	#rotate the node to a newRotation, in degrees
	rotateTo: (newRotation) ->
		this.setRotation(newRotation)

	#getter and setter for the node's rotation.
	#rotation is in degrees and these call the 
	# implementation specific _xc functions.
	rotation: ->
		_xcNodeRotation(this)

	setRotation: (newRotation) ->
		_xcNodeSetRotation(this, newRotation)
	
	#sets the nodes opacity to newOpacity, from 0.0 - 1.0
	fadeTo: (newOpacity) ->
		this.setOpacity(newOpacity)

	#getter and setter for node's opacity.  Opacity is
	# a number from 0.0 to 1.0.  They call the implementation
	# specific _xc functions.
	opacity: -> _xcNodeOpacity(this)

	setOpacity: (newOpacity) ->
		_xcNodeSetOpacity(this, newOpacity)

	# getter and setter for the node's anchors x and y.
	# The anchors are positive or negative numbers, with .5
	# being the center of the node. They call the implementation
	# specific _xc functions.
	anchorX: ->
		_xcNodeAnchorX(this)
	
	anchorY: ->
		_xcNodeAnchorY(this)

	setAnchorX: (newAnchorX) ->
		_xcNodeSetAnchorX(this, newAnchorX)

	setAnchorY: (newAnchorY) ->
		_xcNodeSetAnchorY(this, newAnchorY)

	# returns the node's visibility -
	# true for visible and false for invisible.
	# calls the implementation specific _xc function.
	visible: ->
		_xcNodeVisible(this)
	
	# hides the node by setting its visibility to false
	# calls the implementation specific _xc function.
	hide: ->
		_xcNodeSetVisible(this, false)
	
	#shows the node by setting its visibility to true.
	# calls the implementation specific _xc funciton.
	show: ->
		_xcNodeSetVisible(this, true)

	#getter for the node's Actions.  returns an
	# array of XCActions
	actions: ->  @_actions
	
	#the tick function is called once per frame.  dt
	# is the amount of time since the last call.
	tick: (dt) ->
		#for every action of the node, 
		for action in this.actions()
			#run the action, and if it's done
			if not action.tick(dt)
				#remove it.
				this.removeAction(action)
	
	#run an action for this node.  action is an XCAction			
	runAction: (action) ->
		# is the action new and does it not already have an owner?
		if @_actions.indexOf(action) == -1 and action.owner == null
			#if so, set the owner to this node
			action.setOwner(this)
			# and put it on the action array
			@_actions.push(action)
		else
			#otherwise throw a RunDuplicateAction error
			#FIXME throw a different error if the action just has another owner.
			throw {name:"RunDuplicateActionError", message:"Tried to add action " + action + " to " + this + " twice"}

	#remove an action from this node's actions.  action is the
	# XCAction to remove
	removeAction: (action) ->
		pos = @_actions.indexOf(action)
		# is the action on the node's action array?
		if pos != -1
			# if so, remove it
			@_actions = @_actions[0...pos].concat(@_actions[pos+1...@_actions.length]) 
		else
			#otherwise throw a RemoveActionError. Tried to remove an action that wasn't owned by this node.
			throw {name:"RemoveActionError", message:"Tried to remove action " + action.name + " when it was not added"}
