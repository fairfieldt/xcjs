################# XCNode platform specific implementations #################
class XCCompat
	constructor: ->
		
_xcNodeWidth = (node) ->
	node._width
	
_xcNodeHeight = (node) ->
	node._height

_xcTextNodeWidth = (node) ->
	context.save()
	context.font = node.font
	width = context.measureText(node._text).width
	context.restore()
	node.scaleX() * width
	
_xcTextNodeHeight = (node) ->
	context.save()
	context.font = node.font
	height = context.measureText('m').width
	context.restore()
	node.scaleY() * height

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
	#an XCColor holds r, g, and b values from 0 - 255
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
		
	width: -> _xcNodeWidth(this)
	height: -> _xcNodeHeight(this)
	
	rect: ->
		{x:this.X() - (this.anchorX() * this.width()), y:this.Y() - (this.anchorY() * this.height()), w:this.width(), h:this.height()}

	moveBy: (xOffset, yOffset) ->
		this.setX(this.X() + xOffset)
		this.setY(this.Y() + yOffset)

	moveTo: (xPosition, yPosition) ->
		this.setX(xPosition)
		this.setY(yPosition)
		
	X: -> _xcNodeX(this)
	Y: -> _xcNodeY(this)

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
	
	tick: (dt) ->
		for action in this.actions()
			if not action.tick(dt)
				this.removeAction(action)
				
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
		@font = @fontSize + "pt " + @fontName
		super()
		
	width: -> _xcTextNodeWidth(this)
	
	height: -> _xcTextNodeHeight(this)

	text: -> _xcTextNodeText(this)

	setText: (newText) ->
		_xcTextSetText(this, newText)		
		
	draw: ->
		_xcTextDraw(this)

##########################################################
# XCSpriteNode is an XCNode with an image
# to create an XCSpriteNode, give the constructor an image
# and its width and height.  
#########################################################
class XCSpriteNode extends XCNode
	constructor: (imageName) ->
		@drawable = true
		super()
		@sprite = _xcLoadSprite(imageName)
		@_width = _xcImageWidth(@sprite)
		@_height = _xcImageHeight(@sprite)
		@frame = 0

	draw: ->
		_xcSpriteDraw(this)

#####################################################
# XCAction is the base object for the action system.
# its tick(dt) function is called once per frame and
# is passed the time since the last frame.  
# All actions should extend this class
####################################################
class XCAction
	#an XCAction is created with a name
	constructor: (@name) ->
		#by default, there is no owner of the action.
		@owner = null

	#the default tick does nothing.  dt is the the time in milliseconds
	# since the action was called last.  An action's tick method should
	# return true if the action should continue running or false if it
	# is done and should be removed.
	tick: (dt) ->
		return false
class XCSequenceAction extends XCAction
	constructor: (@actions) ->
		super("XCSequenceAction")
		
	tick: (dt) ->
		currentAction = @actions[0]
					

########################################################
# XCScene objects are the base on-screen element.  
# Like a flip chart, they can be pushed, popped and
# replaced.  
#######################################################
class XCScene 
	constructor: (@name) ->
		@_paused = false
		@_children = []
		@_scheduledFunctions = []
	pause: ->
		@_paused = true
	
	paused: -> @_paused
	
	resume: ->
		@_paused = false
	
	close: ->
	
	tick: (dt) ->
		for child in this.children()
			child.tick(dt)
				
		for scheduled in @_scheduledFunctions
			scheduled.et += dt
			if scheduled.et >= scheduled.interval
				scheduled.function(scheduled.et)
				scheduled.et = 0
		
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
		
	scheduledFunctions: -> @_scheduledFunctions
		
	schedule: (fn, interval) ->
		interval ?= 0
		@_scheduledFunctions.push({function:fn, interval:interval, et:0})
		
	unschedule: (fn) ->
		i = @_scheduledFunctions.indexOf(fn)
		
		unless i == -1
			@_scheduledFunctions = @_scheduledFunctions[0..i].concat(@_scheduledFunctions[i+1..@scheduledFunctions.length])

###############################################
# XCIntervalAction is the base class for actions
# that run for a finite amount of time
###############################################
class XCIntervalAction extends XCAction
	# to create an XCIntervalAction, give it the @duration of time to run
	constructor: (@duration, name) ->
		super(name)
	
	# the interval action's tick subtracts
	# the time since it was last called from the total
	# when @duration is less than 0 it's run its course
	tick: (dt) ->
		@duration -= dt
		#if durantion is <= 0, the action is done.  return false
		return @duration > 0
class XCScaleAction extends XCIntervalAction
	constructor: (duration, name) ->
		super(duration, name)
		@etX = 0
		@etY = 0
		@firstTick = true
	
	tick: (dt) ->
		@etX += dt
		@etY += dt
		newScaleX = @etX * @stepScaleX
		newScaleY = @etY * @stepScaleY
		if Math.abs(newScaleX) > 0
			@etX = 0
		if Math.abs(newScaleY) > 0
			@etY = 0
			
		if Math.abs(@scale.x) - Math.abs(newScaleX) <= 0
			newScaleX = @scale.x
		if Math.abs(@scale.y) - Math.abs(newScaleY) <= 0
			newScaleY = @scale.y
			
		@scale.x -= newScaleY
		@scale.y -= newScaleY
		@owner.scaleXTo(@owner.scaleX() + newScaleX)
		@owner.scaleYTo(@owner.scaleY() + newScaleY)
		super(dt)

class XCScaleToAction extends XCScaleAction
	constructor: (duration, @scale) ->
		super(duration, "XCScaleTo")
		
	tick: (dt) ->
		if @firstTick
			@scale.x -= @owner.scaleX()
			@scale.y -= @owner.scaleY()
			@stepScaleX = @scale.x / @duration
			@stepScaleY = @scale.y / @duration
			@firstTick = false
		super(dt)

class XCScaleByAction extends XCScaleAction
	constructor: (duration, @scale) ->
		super(duration, "XCScaleTo")

	tick: (dt) ->
		if @firstTick
			@scale =  (@scale * @owner.scaleX) - @owner.scaleX()
			@stepScaleX = @scale.x / @duration
			@stepScaleY = @scale.y / @duration
			@firstTick = false
		super(dt)

class XCRotateAction extends XCIntervalAction
	constructor: (duration, name) ->
		super(duration, name)
		@et = 0

	tick: (dt) ->
		@et += dt
		rotation = @et * @stepAngle
		if Math.abs(rotation) > 0
			@et = 0
		if @positiveRotation and (@angle - rotation <= 0)
			rotation = @angle
		else if (not @positiveRotation) and @angle - rotation >= 0
			rotation = @angle
		@angle -= rotation
		@owner.rotateBy(rotation)
		super(dt)

class XCRotateToAction extends XCRotateAction
	constructor: (duration, @angle) ->
		super(duration, "XCRotateTo")
		@firstTick = true

	tick: (dt) ->
		if @firstTick
			@angle -= @owner.rotation()
			@stepAngle = @angle / @duration
			@positiveRotation = @angle > 0
			@firstTick = false
		super(dt)

class XCRotateByAction extends XCRotateAction
	constructor: (duration, @angle) ->
		super(duration, "XCRotateBy")
		@stepAngle = @angle / @duration
		@positiveRotation = @angle > 0
#####################################################
# XCMoveAction is the base move action.  It shouldn't
# be used by itself, instead use one of its children:
# XCMoveTo and XCMoveBy
####################################################
class XCMoveAction extends XCIntervalAction
	constructor: (duration, name) ->
		super(duration, name)
		@etX = 0
		@etY = 0

	tick: (dt) ->
		@etX += dt
		@etY += dt

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
		super(dt)
		
####################################################
# An XCMoveTo action moves its owner to a specified
# x and y coordinate
###################################################
class XCMoveToAction extends XCMoveAction
	constructor: (duration, @x, @y) ->
		super(duration, "XCMoveTo")
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
class XCMoveByAction extends XCMoveAction
	constructor: (duration, @x, @y) ->
		super(duration, "XCMoveBy")
		@stepX = @x / @duration
		@stepY = @y / @duration
		@positiveX = @stepX > 0
		@positiveY = @stepY > 0

#######################################################
# XCEvent is the base object for the event system.  
# All events should extend this object
######################################################
class XCEvent
	#a generic XCEvent is created with a name string
	constructor: (@name) ->

########################################
# These are the XCEvents raised by various
# inputs.
########################################
class XCTapDownEvent extends XCEvent
	constructor: (x, y, @tapNumber) ->
		@point = {x:x, y:y}
		super("tapDown")
		
class XCTapMovedEvent extends XCEvent
	constructor:(x, y, moveX, moveY, @tapNumber) ->
		@point = {x:x, y:y}
		@move = {x:moveX, y:moveY}
		super("tapMoved")

class XCTapUpEvent extends XCEvent
	constructor: (x, y, @tapNumber) ->
		@point = {x:x, y:y}
		super("tapUp")

class XCKeyDownEvent extends XCEvent
	constructor: (@key) ->
		super("keyDown")

class XCKeyUpEvent extends XCEvent
	constructor: (@key) ->
		super("keyUp")

class XCDelayAction extends XCAction
	constructor: (@time) ->
		super('XCDelayAction')
###############################
# XCButtonNode
#
###############################

class XCButtonNode extends XCSpriteNode
	constructor: (imageName) ->
		super(imageName)
		xc.addEventListener('tapDown', this)
		xc.addEventListener('tapUp', this)
		xc.addEventListener('tapMoved', this)
		
	tapDown: (event) ->
		if xc.rectContainsPoint(this.rect(), event.point)
			@tapStarted = true
			this.scaleTo(1.1)
			
	tapMoved: (event) ->
		if not xc.rectContainsPoint(this.rect(), event.point)
			@tapStarted = false
			this.scaleTo(1.0)
			
	tapUp: (event) ->
		if @tapStarted and xc.rectContainsPoint(this.rect(), event.point)
			if this.onHit
				this.onHit()
				this.scaleTo(1.0)
		@tapStarted = false

#######################################################
# the xc object is the controller for an xc application
# it provides an extensible event system with input
# events and scene management.
######################################################



class xc
	constructor: ->
		#_scenes is the array of scenes, the last one is the current scene
		@_scenes = []
		#add an empty scene for the default scene
		@_scenes.push new XCScene('DefaultScene')

	# add an object to listen for an event
	# eventName is the name of the event to listen to
	# and listener is an object that has a method with that name
	addEventListener: (eventName, listener) ->
		# are there currently any listeners for the specified event?
		if not @[eventName]
			# if not, make an empty array to hold them
			@[eventName] = []
		# is the object already listening for this event?
		if @[eventName].indexOf(listener) == -1
			#if not, put it on the array of listeners
			@[eventName].push(listener)
		else
			#otherwise throw an EventListenerAlreadyAddedError
			message = 'The event listener for ' + eventName + ' ' + listener +
					' was already added'
			throw {name:'EventListenerAlreadyAddedError', message:message}
	
	#remove an object from the listeners for the specified event
	# eventName is the name of the event to listen to and
	# listener is the object to remove from listeners
	removeEventListener: (eventName, listener) ->
		#are there any listeners for that event and is listener one of them?
		if @[eventName]? and (pos = @[eventName].indexOf(listener)) != -1
			#if so, remove it.
			@[eventName] = @[eventName][0...pos].concat(@[eventName][pos+1..@[eventName].length-1])
		else
			#otherwise throw a NoSuchEventListenerError
			message = 'There is no listener for ' + eventName + ' ' + listener
			throw {name:'NoSuchEventListenerError', message:message}
		

	# given an event, pass it to all of the listeners
	dispatchEvent: (event) ->
		# are there any listeners?
		if @[event.name]?
			#if so, call the appropriate handler for each of them.
			for listener in @[event.name]
				listener[event.name](event)
	
	# given a scene, replace the current scene with the new scene
	# newScene is an XCScene
	replaceScene: (newScene) ->
		#is newScene on the stack?
		unless @_scenes.indexOf(newScene) != -1
			#if not, close the current scene
			oldScene = @_scenes.pop().close()
			#and replace it with the new scene
			@_scenes.push(newScene)
			return oldScene
		else
			# otherwise throw a DuplicateSceneError.  
			throw {name:'DuplicateSceneError', message:'Cannot replace a scene with itself'}
	
	#given a scene, make it the currentScene.  All scenes currently on the stack
	# are moved back one.
	pushScene: (newScene) ->
		#is newScene on the stack?
		if @_scenes.indexOf(newScene) == -1
			#if not, push it on.  It's now the current scene.
			@_scenes.push(newScene)
		else
			#otherwise throw a DuplicateSceneError
			throw {name:'DuplicateSceneError', message:'Cannot put a scene on the stack twice'}
	
	#remove the current scene from the stack and return it.  
	popScene: ->
		#is there going to be a scene left after removing the current one?
		if @_scenes.length > 1
			#if so, pop it, close it, and return it
			oldScene = @_scenes.pop()
			oldScene.close()
			return oldScene
		else
			#otherwise throw a PoppedLastSceneError.  you can't pop the last scene.
			throw {name:'PoppedLastSceneError', message:'Can\'t pop with one scene left'}
	
	#returns the current XCScene	
	getCurrentScene: -> 
		@_scenes[@_scenes.length-1]
		
	#helper function to determine if a rectangle contains a point.
	# rect is an object {x,y,w,h} and point is an object {x,y}
	rectContainsPoint: (rect, point) ->
		(point.x > rect.x) and (point.x < (rect.x + rect.w)) and
		(point.y > rect.y) and (point.y < (rect.y + rect.h))
		


