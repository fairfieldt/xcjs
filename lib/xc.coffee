################# XCNode platform specific implementations #################
class XCCompat
	constructor: ->

_xcNodeX = (node) ->
	node._x

_xcNodeY = (node) ->
	node._y

_xcNodeSetX = (node, newX) ->
	node._x = newX

_xcNodeSetY = (node, newY) ->
	node._y = newY
	
_xcNodeLayer = (node) ->
	node._layer
	
_xcNodeSetLayer = (node, newLayer) ->
	node._layer = newLayer

_xcNodeColor = (node) ->
	node._color

_xcNodeSetColor = (node, newColor) ->
	node._color = newColor

_xcNodeScaleX = (node) ->
	node._scaleX

_xcNodeScaleY = (node) ->
	node._scaleY

_xcNodeSetScaleX = (node, newScaleX) ->
	node._scaleX = newScaleX

_xcNodeSetScaleY = (node, newScaleY) ->
	node._scaleY = newScaleY

_xcNodeRotation = (node) ->
	node._rotation

_xcNodeSetRotation = (node, newRotation) ->
	while newRotation > 360
		newRotation = newRotation - 360
	while newRotation < 0
		newRotation = 360 + newRotation
	node._rotation = newRotation
	
_xcNodeOpacity = (node) ->
	node._opacity

_xcNodeSetOpacity = (node, newOpacity) ->
	if newOpacity < 0
		newOpacity = 0
	else if newOpacity > 1.0
		newOpacity = 1.0
	
	node._opacity = newOpacity
	
_xcNodeAnchorX = (node) -> 
	node._anchorX

_xcNodeAnchorY = (node) -> 
	node._anchorY

_xcNodeSetAnchorX = (node, newAnchorX) ->
	node._anchorX = newAnchorX

_xcNodeSetAnchorY = (node, newAnchorY) ->
	node._anchorY = newAnchorY
	
_xcNodeVisible = (node) ->
	node._visible
	
_xcNodeSetVisible = (node, visible) ->
	node._visible = visible

_xcTextNodeText = (node) ->
	node._text

_xcTextSetText = (node, newText) ->
	node._text = newText

######################################################
# XCColor is a data class to store an rgb color
######################################################
class XCColor
	constructor: (@r, @g, @b) ->
#################################################################
# XCNode is the base for most objects in an xc application.
# XCNodes have xy positions, scale, rotation, opacity, and color.
# For drawable nodes these will affect their appearance on screen.
# They also have x and y anchor points which effect things such
# as rotation.
# ###############################################################



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

#########################################################
# XCTextNode is an XCNode that displays text
# You can set the fontName and fontsize at initialization
# and change the text at any time. 
#########################################################
class XCTextNode extends XCNode
	constructor: (@_text, @fontName, @fontSize) ->
		@drawable = true
		@ref = _xcLoadText(this)
		
		super()

	text: -> _xcTextNodeText(this)

	setText: (newText) ->
		_xcTextSetText(this, newText)		
		
	draw: ->
		_xcTextDraw(this)
##########################################################
# XCSpriteNode is an XCNode with an image
# to create an XCSpriteNode, give the constructor an image
# and its width and height.  TODO: I may remove the width
# and height requirement
#########################################################
class XCSpriteNode extends XCNode
	constructor: (imageName) ->
		@drawable = true
		super()
		@sprite = _xcLoadSprite(imageName)
		@width = _xcImageWidth(@sprite)
		@height = _xcImageHeight(@sprite)
		@frame = 0

	draw: ->
		_xcSpriteDraw(this)
########################################################
# XCScene objects are the base on-screen element.  
# Like a flip chart, they can be pushed, popped and
# replaced.  
#######################################################
class XCScene 
	constructor: (@name) ->
		@_paused = false
		@_children = []
	pause: ->
		@_paused = true
	
	paused: -> @_paused
	
	resume: ->
		@_paused = false
	
	close: ->
		
	addChild: (child) ->
		unless child.parent == null
			throw {name: 'DuplicateChildError', message:'Node already a child of another scene'}
		if @_children.indexOf(child) == -1
			@_children.push(child)
			child.parent = this
		else
			throw {name:'DuplicateChildError', message:'Can\'t add the same child twice'}

	removeChild: (child) ->
		pos = @_children.indexOf(child)
		if pos != -1
			@_children = @_children[0...pos].concat(@_children[pos+1...@_children.length])
			child.parent = null
		else
			throw {name:'NodeNotChildError', message:'Can\'t remove a node that is not a child'}
			
	children: ->
		@_children
#####################################################
# XCAction is the base object for the action system.
# its tick(dt) function is called once per frame and
# is passed the time since the last frame.  
# All actions should extend this class
####################################################
class XCAction
	constructor: (@name) ->
		@owner = null

	tick: (dt) ->
class XCScaleAction extends XCAction
	constructor: (name) ->
		super(name)
		@et = 0
		@firstTick = true
	
	tick: (dt) ->
		if @scale == 0
			@owner.removeAction(this)
		@et += dt
		newScale = @et * @stepScale
		if Math.abs(newScale) > 0
			@et = 0
		if Math.abs(@scale) - Math.abs(newScale) <= 0
			newScale = @scale
		@scale -= newScale
		@owner.scaleTo(@owner.scaleX + newScale)

class XCScaleTo extends XCScaleAction
	constructor: (@duration, @scale) ->
		super("XCScaleTo")
		
	tick: (dt) ->
		if @firstTick
			@scale -= @owner.scaleX()
			@stepScale = @scale / @duration
			@firstTick = false
		super(dt)

class XCScaleBy extends XCScaleAction
	constructor: (@duration, @scale) ->
		super("XCScaleTo")

	tick: (dt) ->
		if @firstTick
			@scale =  (@scale * @owner.scaleX) - @owner.scaleX()
			@stepScale = @scale / @duration
			@firstTick = false
		super(dt)

class XCRotateAction extends XCAction
	constructor: (name) ->
		super(name)
		@et = 0

	tick: (dt) ->
		@et += dt
		rotation = @et * @stepAngle
		if Math.abs(rotation) > 0
			@et = 0
		if @positiveRotation and (@angle - rotation <= 0)
			rotation = @angle
			@owner.removeAction(this)
		else if (not @positiveRotation) and @angle - rotation >= 0
			rotation = @angle
			@owner.removeAction(this)
		@angle -= rotation
		@owner.rotateBy(rotation)

class XCRotateTo extends XCRotateAction
	constructor: (@duration, @angle) ->
		super("XCRotateTo")
		@firstTick = true

	tick: (dt) ->
		if @firstTick
			@angle -= @owner.rotation()
			@stepAngle = @angle / @duration
			@positiveRotation = @angle > 0
			@firstTick = false
		super(dt)

class XCRotateBy extends XCRotateAction
	constructor: (@duration, @angle) ->
		super("XCRotateBy")
		@stepAngle = @angle / @duration
		@positiveRotation = @angle > 0
#####################################################
# XCMoveAction is the base move action.  It shouldn't
# be used by itself, instead use one of its children:
# XCMoveTo and XCMoveBy
####################################################
class XCMoveAction extends XCAction
	constructor: (name) ->
		super(name)
		@etX = 0
		@etY = 0

	tick: (dt) ->
		@etX += dt
		@etY += dt

		if @x == 0 and @y == 0
			@owner.removeAction(this)
		else
			moveX = @etX * @stepX
			moveY = @etY * @stepY
			
			if Math.abs(moveX) > 0
				@etX = 0
			if Math.abs(moveY)> 0
				@etY = 0

			if @positiveX and  (@x - moveX < 0)
				moveX = @x
			else if (not @positiveX) and (@x - moveX > 0)
				moveX = @x
			if @positiveY and (@y - moveY < 0)
				moveY = @y
			else if (not @positiveY) and (@y - moveY > 0)
				moveY = @y
			@x -= moveX
			@y -= moveY
			
			@owner.moveBy(moveX, moveY)
		
####################################################
# An XCMoveTo action moves its owner to a specified
# x and y coordinate
###################################################
class XCMoveTo extends XCMoveAction
	constructor: (@duration, @x, @y) ->
		super("XCMoveTo")
		@firstTick = true

	tick: (dt) ->
		if @firstTick
			@x -= @owner.X()
			@y -= @owner.Y()
			@stepX = @x / @duration
			@stepY = @y / @duration
			@positiveX = @stepX > 0
			@positiveY = @stepY > 0
			@firstTick = false
			
		super(dt)

###################################################
# An XCMoveBy action moves its owner a specified 
# amount x,y
###################################################
class XCMoveBy extends XCMoveAction
	constructor: (@duration, @x, @y) ->
		super("XCMoveBy")
		@stepX = @x / @duration
		@stepY = @y / @duration
		@positiveX = @stepX > 0
		@positiveY = @stepY > 0

#######################################################
# XCEvent is the base object for the event system.  
# All events should extend this object
######################################################
class XCEvent
	constructor: (@name) ->

class XCTapDownEvent extends XCEvent
	constructor: (@x, @y, @tapNumber) ->
		super("tapDown")
		
class XCTapMovedEvent extends XCEvent
	constructor:(@x, @y, @moveX, @moveY, @tapNumber) ->
		super("tapMoved")

class XCTapUpEvent extends XCEvent
	constructor: (@x, @y, @tapNumber) ->
		super("tapUp")

class XCKeyDownEvent extends XCEvent
	constructor: (@key) ->
		super("keyDown")

class XCKeyUpEvent extends XCEvent
	constructor: (@key) ->
		super("keyUp")
#######################################################
# the xc object is the controller for an xc application
# it provides an extensible event system with input
# events and scene management.
######################################################



class xc
	constructor: ->
		@_scenes = []
		@_scenes.push new XCScene('DefaultScene')

	addEventListener: (eventName, listener) ->
		if not @[eventName]
			@[eventName] = []
		if @[eventName].indexOf(listener) == -1
			@[eventName].push(listener)
		else
			throw {name:'EventListenerAlreadyAddedError', message: 'The event listener for ' + eventName + ' ' + listener + ' was already added'}
		
	removeEventListener: (eventName, listener) ->
		if @[eventName]? and pos = @[eventName].indexOf(listener) != -1
			@[eventName] = @[eventName][0...pos].concat(@[eventName][pos+1...@[eventName].length]) 
		else
			throw {name:'NoSuchEventListenerError', message:'There is no listener for ' + eventName + ' ' + listener}
			
		
		
	dispatchEvent: (event) ->
		if @[event.name]?
			for listener in @[event.name]
				listener[event.name](event)

	replaceScene: (newScene) ->
		unless newScene == this.getCurrentScene()
			@_scenes.pop().close()
			@_scenes.push(newScene)
		else
			throw {name:'DuplicateSceneError', message:'Cannot replace a scene with itself'}
	pushScene: (scene) ->
		if @_scenes.indexOf(scene) == -1
			@_scenes.push(scene)
		else
			throw {name:'DuplicateSceneError', message:'Cannot put a scene on the stack twice'}
		
	popScene: ->
		if @_scenes.length > 1
			@_scenes.pop().close()
		else
			throw {name:'PoppedLastSceneError', message:'Can\'t pop with one scene left'}
		
	getCurrentScene: -> 
		@_scenes[@_scenes.length-1]
		




		


