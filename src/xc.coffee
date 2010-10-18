#######################################################
# the xc object is the controller for an xc application
# it provides an extensible event system with input
# events and scene management.
######################################################

class xc
	constructor: ->
		@scenes = []
		@scenes.push new XCSceneNode()
		@actions = []

	addEventListener: (eventName, listener) ->
		if not this[eventName]
			this[eventName] = []
		this[eventName].push(listener)
		
	dispatchEvent: (event) ->
		if this[event.name]?
			for listener in this[event.name]
				if listener[event.name](event)
					break

	replaceScene: (newScene) ->
		@scenes.pop().close()
		@scenes.push(newScene)
		
	pushScene: (scene) ->
		scenes.push(scene)
		
	popScene: ->
		@scenes.pop()
		
	getCurrentScene: -> 
		@scenes[@scenes.length-1]

#################################################################
# XCNode is the base for most objects in an xc application.
# Nodes are arranged in a parent-child hierarchy and 
# their position is relative to their parents.
#
# XCNodes have xy positions, scale, rotation, opacity, and color.
# For drawable nodes these will affect their appearance on screen.
# They also have x and y anchor points which effect things such
# as rotation.
# ###############################################################

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

##########################################################
# XCSpriteNode is an XCNode with an image
# to create an XCSpriteNode, give the constructor an image
# and its width and height.  TODO: I may remove the width
# and height requirement
#########################################################
class XCSpriteNode extends XCNode
	constructor: (imageName, @width, @height) ->
		@drawable = true
		super()
		@sprite = _xcLoadSprite(imageName)
		@frame = 0

	draw: ->
		_xcSpriteDraw(this)
		
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
########################################################
# XCSceneNode objects are the base on-screen element.  
# Like a flip chart, they can be pushed, popped and
# replaced.  
#######################################################
class XCSceneNode extends XCNode
	constructor: ->
		super()

	close: ->

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

######################################################
# XCColor is a data class to store an rgb color
######################################################
class XCColor
	constructor: (@r, @g, @b) ->
		
#####################################################
# XCAction is the base object for the action system.
# its tick(dt) function is called once per frame and
# is passed the time since the last frame.  
# All actions should extend this class
####################################################
class XCAction
	constructor: (@name) ->

	tick: (dt) ->

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
