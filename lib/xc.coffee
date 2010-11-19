###
Copyright 2010 Tom Fairfield. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY TOM FAIRFIELD ``AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of Tom Fairfield.
###
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
		
		#nodes should start with their anchor at 0,0
		this.setAnchorX(0.0)
		this.setAnchorY(0.0)
	
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

#########################################################
# XCTextNode is an XCNode that displays text
# You can set the fontName and fontsize at initialization
# and change the text at any time. 
#########################################################
class XCTextNode extends XCNode
	constructor: (@_text, @fontName, @fontSize) ->
		#since a TextNode is drawable, set this to trude
		@drawable = true
		
		#@ref is the reference to the text node.
		# it's implementation specific and, as such
		# is loaded by an _xc function.  Some implementations
		# may not use it at all.
		@ref = _xcLoadText(this)
		
		#store the font as needed by the canvas implementation
		#TODO: move this to a better place.
		@font = @fontSize + "pt " + @fontName
		super()
	
	#getters for the width and height.
	#these need to be different than the
	#generic node getters because of the
	#canvas implementation.  	
	width: -> _xcTextNodeWidth(this)
	
	height: -> _xcTextNodeHeight(this)

	#getter and setter for the node text.
	# these will change or get the text that is
	# displayed by this node. They call the 
	#implementation specific _xc functions.
	text: -> _xcTextNodeText(this)

	setText: (newText) ->
		_xcTextSetText(this, newText)		
	
	#draw is called every frame for @drawable nodes	
	draw: ->
		#to draw a TextNode, call the implementation
		#specific _xcTextDraw.
		_xcTextDraw(this)

##########################################################
# XCSpriteNode is an XCNode with an image
# to create an XCSpriteNode, give the constructor an image name 
#########################################################
class XCSpriteNode extends XCNode
	#create an XCSpriteNode with the name of the image
	#it will display
	constructor: (imageName) ->
		#since a SpriteNode is drawable, set this to true
		@drawable = true
		super()
		
		#load the sprite with the implementation specific _xc function.
		@sprite = _xcLoadSprite(imageName)
		
		#get the width and height with the 
		#implementation specific _xc functions.
		@_width = _xcImageWidth(@sprite)
		@_height = _xcImageHeight(@sprite)
		
		#FIXME this doesn't do anything
		@frame = 0

	#draw is called every tick for @drawable nodes
	draw: ->
		#to draw the node, call the implementation specific
		# _xcSpriteDraw function.
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
	
	# when an action is run, the owner calls this function with itself	
	setOwner: (owner) ->
		@owner = owner
##############################################
# an XCSequenceAction is an action that
# runs a list of XCActions serially.
##############################################
class XCSequenceAction extends XCAction
	#to create an XCSequenceAction, give it an array of the actions
	# it should run.
	constructor: (@actions) ->
		super("XCSequenceAction")
		
	tick: (dt) ->
		# are there any actions left?
		if @actions.length == 0
			#if not, this action is done.
			return false
		#otherwise, get the first one.
		currentAction = @actions[0]
		#and run it.  Is the current action done?
		if not currentAction.tick(dt)
			# if so, remove it from the list.
			@actions = @actions[1..@actions.length]
		#keep running.
		return true
	
	# since all of the actions in the sequence need to be owned by the owner of the sequence,
	# do that here.				
	setOwner: (owner) ->
		super(owner)
		for action in @actions
			action.setOwner(@owner)
########################################################
# XCScene objects are the base on-screen element.  
# Like a flip chart, they can be pushed, popped and
# replaced.  
#######################################################
class XCScene 
	# a scene is given a name to identify it
	constructor: (@name) ->
		
		#these underscore prefixed variables are,
		#by convention private.  
		@_paused = false
		@_children = []
		@_scheduledFunctions = []
	
	#pause the scene.  Actions stop running.
	#TODO: make this work so input is still processed (I think it is)
	#and drawing still happens.  (I think it does)
	pause: ->
		@_paused = true
	
	#paused will return true if the scene is paused, false otherwise
	paused: -> @_paused
	
	#resume the scene.  All actions are started again.
	resume: ->
		@_paused = false
	
	#close is called when a scene is removed.  Cleanup, particularly
	#implementation specific, should happen here.
	close: ->
	
	#tick is called once per frame.  dt is the time in milliseconds
	#since it was called last.
	tick: (dt) ->
		#for all of the children XCNodes, call their tick function.
		for child in this.children()
			child.tick(dt)
		
		#for all scheduled functions		
		for scheduled in @_scheduledFunctions
			#add the dt to the total elapsed time since the scheduled 
			#function was called.
			scheduled.et += dt
			# is the elapsed time at least the scheduled interval for 
			#this function?
			if scheduled.et >= scheduled.interval
				#if so, call the function
				scheduled.function(scheduled.et)
				#and reset its elapsed time to 0
				scheduled.et = 0
	
	#add an XCNode as a child to this scene.  Children are drawn and updated by the active scene
	#child is an XCNode to add	
	addChild: (child) ->
		#does the child already have a parent?
		unless child.parent() == null
			#if so, throw a DuplicateChildError.  Nodes can only be on one scene ata  time.
			throw {name: 'DuplicateChildError', message:'Node already a child of another scene'}
		#is the child already on the list of children?
		if @_children.indexOf(child) == -1
			#if not, add it
			@_children.push(child)
			# and make this scene its parent.
			child.setParent(this)
		else
			#otherwise throw a DuplicateChildError.  The node is already this scene's child.
			throw {name:'DuplicateChildError', message:'Can\'t add the same child twice'}
			
	#remove a child from the scene.  
	#child should be an XCNode that is a child of this scene.
	removeChild: (child) ->
		pos = @_children.indexOf(child)
		#is the child on the list of children?
		if pos != -1
			#if so, remove it
			@_children = @_children[0...pos].concat(@_children[pos+1...@_children.length])
			#and set its parent to null
			child.setParent(null)
		else
			#otherwise throw a NodeNotChildError.  You tried to remove a node that wasn't this scene's child.
			throw {name:'NodeNotChildError', message:'Can\'t remove a node that is not a child'}
	
	#getter for the scene's children.
	#returns an array of XCNodes		
	children: ->
		@_children
	
	#getter for the scene's scheduled functions.
	#returns an array of functions.	
	scheduledFunctions: -> @_scheduledFunctions
	
	#schedule a function, fn, to be called at an interval, interval, in seconds	
	schedule: (fn, interval) ->
		#if no interval is passed, this function should be called every frame
		interval ?= 0
		#add a scheduledFunction object to the list.
		#function is the function to be called, interval is the frequency with which to call it,
		# and et is the elapsed time which will accumulate every frame.
		this.scheduledFunctions().push({function:fn, interval:interval, et:0})
	
	#unschedule a function, fn, from this scene.
	unschedule: (fn) ->
		fnObject = null
		for scheduled in this.scheduledFunctions()
			if scheduled.function == fn
				fnObject = scheduled
				break
		i = this.scheduledFunctions().indexOf(fnObject)
		# is the function scheduled?  
		unless i == -1
			#if so, remove it
			@_scheduledFunctions = @_scheduledFunctions[0..i].concat(@_scheduledFunctions[i+1..@scheduledFunctions.length])
		else
			#TODO should throw an exception here
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
#####################################################
# XCScaleAction is the base scale action.  It shouldn't
# be used by itself, instead use one of its children:
# XCScaleToAction or XCScaleByAction
####################################################

class XCScaleAction extends XCIntervalAction
	#duration is the time to take to scale, and name is the name
	# of the specific scale action
	constructor: (duration, name) ->
		super(duration, name)
		#etX and etY are the accumulated elapsed time since
		#the last actual change.  They should start at 0
		@etX = 0
		@etY = 0
		
		#since we need to do some setup on the first tick,
		#keep track of it.
		@firstTick = true
	
	tick: (dt) ->
		#add dt to the elapsed time since change in x and y
		@etX += dt
		@etY += dt
		
		#calculate the new scale for this step
		#stepScaleX and stepScaleY need to be calculated
		#by a subclass
		newScaleX = @etX * @stepScaleX
		newScaleY = @etY * @stepScaleY
		
		#if we've changed scale in the x direction or the y direction
		#set that elapsed time to 0.  Sometimes a tick will be fast enough
		#or a move small enough that the scale won't be big enough to
		#actually change every tick.
		if Math.abs(newScaleX) > 0
			@etX = 0
		if Math.abs(newScaleY) > 0
			@etY = 0
		
		#taking into account the direction of the scale (positive or negative),
		# make sure that we haven't overshot our goal.  If the amount to scale
		#this tick is bigger than the total amount to scale left, set the amount
		#to scale this tick to the total left.  That way we are sure to move
		#the proper amount.  
		if Math.abs(@scale.x) - Math.abs(newScaleX) <= 0
			newScaleX = @scale.x
		if Math.abs(@scale.y) - Math.abs(newScaleY) <= 0
			newScaleY = @scale.y
		
		#now subtract the amount to scale this tick from
		# the total amount left to scale for both x and y
		@scale.x -= newScaleY
		@scale.y -= newScaleY
		
		#and scale the owner to the appropriate scale
		@owner.scaleXTo(@owner.scaleX() + newScaleX)
		@owner.scaleYTo(@owner.scaleY() + newScaleY)
		
		#finally call the XCIntevalAction's tick
		super(dt)
		
#####################################################
# an XCScaleToAction scales a node to an absolute scale,
# @scale
####################################################
class XCScaleToAction extends XCScaleAction
	constructor: (duration, @scale) ->
		super(duration, "XCScaleTo")
		
	tick: (dt) ->
		#is it the first tick?
		if @firstTick
			#if so, make the x and y scales relative to
			#the node's current scale.  The parent XCScaleAction
			#wants it this way.
			@scale.x -= @owner.scaleX()
			@scale.y -= @owner.scaleY()
			
			#calculate the amount to scale per second for x and y
			@stepScaleX = @scale.x / @duration
			@stepScaleY = @scale.y / @duration
			
			#we've handled the first tick
			@firstTick = false
		#call the XCScaleAction's tick
		super(dt)

#####################################################
# an XCScaleByAction scales a node by an amount,
# @scale, relative to the node's current scale.
# the scale is multiplicative.
####################################################
class XCScaleByAction extends XCScaleAction
	constructor: (duration, @scale) ->
		super(duration, "XCScaleTo")

	tick: (dt) ->
		#is it the first tick?
		if @firstTick
			
			#calculate the relative scale for both x and y based on
			#the node's current scale.  
			@scale.x =  (@scale.x * @owner.scaleX()) - @owner.scaleX()
			@scale.y = (@scale.y * @owner.scaleY()) - @owner.scaleX()
			
			#calculate the amount to scale per second for both x and y.
			@stepScaleX = @scale.x / @duration
			@stepScaleY = @scale.y / @duration
			@firstTick = false
		#call the XCScaleAction parent's tick
		super(dt)

#####################################################
# XCRotateAction is the base rotate action.  It shouldn't
# be used by itself, instead use one of its children:
# XCRotateToAction or XCRotateByAction
####################################################
class XCRotateAction extends XCIntervalAction
	#create an XCRotateAction with duration, the time in seconds to run
	# and name, the name of the action.  
	constructor: (duration, name) ->
		super(duration, name)
		@et = 0
	
	tick: (dt) ->
		#add the time since last call to the total elapsed time since an
		#actual rotation was made.  Sometimes dt will be small enough that
		#the rotation isn't actually made every tick.  
		@et += dt
		#calcuate the rotation for the current elapsed time
		#stepAngle needs to be set by a subclass of XCRotateAction
		rotation = @et * @stepAngle
		
		#is |rotation| > 0?  That is, are we rotating at all
		if Math.abs(rotation) > 0
			#if so, set the elapsed time since last rotation to 0
			@et = 0
			
		#taking into account the direction of the rotation (positive or negative),
		# check to see if the rotation this step is more than the total rotation
		# left.  If it is, set the rotation this step to the total left.  Otherwise
		# the node will rotate too far. 
		if @positiveRotation and (@angle - rotation <= 0)
			rotation = @angle
		else if (not @positiveRotation) and @angle - rotation >= 0
			rotation = @angle
			
		#now subtract the rotation this step from the total rotation left to do
		@angle -= rotation
		
		#and rotate the owner by the rotation this step
		@owner.rotateBy(rotation)
		
		#then call the IntervalAction's tick
		super(dt)

#####################################################
# an XCRotateToAction rotates the node to a new angle,
# in degrees	
####################################################
class XCRotateToAction extends XCRotateAction
	#duration is the time to take to rotate and @angle is the angle to rotate to, in degrees
	constructor: (duration, @angle) ->
		super(duration, "XCRotateTo")
		#need to do some special processing on the first tick, so make sure
		#we know when that is.
		@firstTick = true

	tick: (dt) ->
		# is this the first tick for this action?
		if @firstTick
			#if so, modify angle so that it's relative to the current rotation.
			# the parent XCRotateAction wants it this way
			@angle -= @owner.rotation()
			
			#caculate the degrees to rotate each second
			@stepAngle = @angle / @duration
			
			#positiveRotation tells whether we're rotating in a positive or
			#negative direction.  This is needed to prevent overrotation.
			@positiveRotation = @angle > 0
			
			#we've handled the first tick, so set firstTick to false
			@firstTick = false
		#call the parent XCRotateAction's tick
		super(dt)

#####################################################
# XCRotateByAction rotates a node by an angle, in 
# degrees, relative to the node's current position.
####################################################
class XCRotateByAction extends XCRotateAction
	#duration is the time to take to rotate and @angle is the angle to rotate by, in degrees
	constructor: (duration, @angle) ->
		super(duration, "XCRotateBy")
		#calculate the degrees to rotate per second
		@stepAngle = @angle / @duration
		
		#positiveRotation tells whether we're rotating in a positive or
		#negative direction.  This is needed to prevent overrotation.
		@positiveRotation = @angle > 0
#####################################################
# XCMoveAction is the base move action.  It shouldn't
# be used by itself, instead use one of its children:
# XCMoveTo and XCMoveBy
####################################################
class XCMoveAction extends XCIntervalAction
	# to create an XCMoveAction, the duration, in seconds,
	# and the name is required.  XCMoveAction objects
	# should never be created directly, only sub-classed.
	constructor: (duration, name) ->
		super(duration, name)
		#set the elapsed time for x and y moves to 0
		@etX = 0
		@etY = 0


	tick: (dt) ->
		#elapsed time x and y are both incremented by dt,
		# the time since the last actual move in that direction.
		# sometimes the tick will be fast enough that the action
		# won't move an entire pixel in one direction.
		@etX += dt
		@etY += dt
		
		# then calculate how far to move in the x direction and y direction
		# stepX and stepY need to be calculated beforehand by the subclass of
		# XCAction
		moveX = @etX * @stepX
		moveY = @etY * @stepY
		
		#if |moveX| is > 0 (that is, we're moving at least one pixel), 
		# reset etX to 0.
		if Math.abs(moveX) > 0
			@etX = 0
		#if |moveY| is > 0 (that is, we're moving at least one pixel),
		# reset etY to 0.
		if Math.abs(moveY) > 0
			@etY = 0

		#taking into account the direction of the X movement,
		# if moveX (the distance we're trying to move this tick)
		# is greater magnitude than the total distance left to move,
		# set moveX to be the total distance left to move.
		if @positiveX and  (@x - moveX < 0)
			moveX = @x
		else if (not @positiveX) and (@x - moveX > 0)
			moveX = @x
		
		#and here, the same as X but for Y.  Make sure we don't move farther total
		# then we wanted to	
		if @positiveY and (@y - moveY < 0)
			moveY = @y
		else if (not @positiveY) and (@y - moveY > 0)
			moveY = @y
		# now subtract the distance we're going to move this tick from
		# the total distance left to move
		@x -= moveX
		@y -= moveY
	
		# and finally, move the owner the appropriate distance.
		@owner.moveBy(moveX, moveY)
		
		#always call the superclasses tick for interval actions
		#that's how the action knows when to stop.  
		super(dt)
		
####################################################
# An XCMoveTo action moves its owner to a specified
# x and y coordinate
###################################################
class XCMoveToAction extends XCMoveAction
	
	#x and y are absolute coordinates to move to
	constructor: (duration, @x, @y) ->
		super(duration, "XCMoveTo")
		
		#we need to do some special calculations on the first tick,
		#so make sure we know when it is.
		@firstTick = true

	tick: (dt) ->
		#is this the first tick for this action?
		if @firstTick
			#if so, adjust @x and @y so that they are
			#relative to the owner.  This is how the
			#generic Move action wants them.
			@x -= @owner.X()
			@y -= @owner.Y()
			
			#then calculate the distance we want to move in each
			#direction per second.  
			@stepX = @x / @duration
			@stepY = @y / @duration
			
			#positiveX and positiveY let us know whether the
			# movement is in a positive or negative direction.
			# this is necessary at the end of a move to prevent
			# moving too far.  Might as well calculate it here.
			@positiveX = @stepX > 0
			@positiveY = @stepY > 0
			
			#it's no longer the first tick.
			@firstTick = false
		
		#call the generic Move action's tick
		super(dt)

###################################################
# An XCMoveBy action moves its owner a specified 
# amount x,y
###################################################
class XCMoveByAction extends XCMoveAction
	
	#x and y are coordinates relative to the owner
	constructor: (duration, @x, @y) ->
		super(duration, "XCMoveBy")
		#calculate the distance we want to move in each direction
		#per second. 
		@stepX = @x / @duration
		@stepY = @y / @duration
		
		#positiveX and positiveY let us know whether the
		# movement is in a positive or negative direction.
		# this is necessary at the end of a move to prevent
		# moving too far.  Might as well calculate it here.
		@positiveX = @stepX > 0
		@positiveY = @stepY > 0

#######################################################
# XCEvent is the base object for the event system.  
# All events should extend this object
######################################################
class XCEvent
	#a generic XCEvent is created with a name string
	constructor: (@name) ->

# These are the XCEvents raised by various inputs.


#################################################
# an XCTapDown event is created when a tap 
# (or mouse click) is detected.  
#################################################
class XCTapDownEvent extends XCEvent
	#x and y are the tap coordinates
	# and @tapNumber is the id of the tap
	# for multi-touch.  tapNumber is currently
	#unimplemented.  
	constructor: (x, y, @tapNumber) ->
		#create a point object with the x and y coords
		@point = {x:x, y:y}
		super("tapDown")

#################################################
# an XCTapMoved event is created when a current tap
# (or mouse click) moves.  
#################################################		
class XCTapMovedEvent extends XCEvent
	#x and y are the tap coordinates after the move
	# moveX and moveY are the distance the tap moved
	# since the last event.  tapNumber is the id of the
	# tap for multi-touch.  It is currently unimplemented.
	constructor:(x, y, moveX, moveY, @tapNumber) ->
		#create a point object with x and y
		@point = {x:x, y:y}
		#create a point object with moveX and moveY
		#FIXME this isn't really a point object, they are ds
		@move = {x:moveX, y:moveY}
		super("tapMoved")

#################################################
# an XCTapUp event is created when a tap (or mouse
# click) is releasted.  
#################################################
class XCTapUpEvent extends XCEvent
	#x and y are the coordinates where the
	# tap was released.  tapNumber is the
	#id of the tap for multi-touch.  It is currently
	#unimplemented.  
	constructor: (x, y, @tapNumber) ->
		#create a point object with x and y
		@point = {x:x, y:y}
		super("tapUp")

#################################################
# an XCKeyDown event is created when a keyboard
# key is pressed.  
#################################################
class XCKeyDownEvent extends XCEvent
	# @key is the id of the key that was pressed
	constructor: (@key) ->
		super("keyDown")
		
#################################################
# an XCKeyUp event is created when a pressed keyboard
# key is unpressed.
#################################################
class XCKeyUpEvent extends XCEvent
	# @key is the id of the key that was unpressed.
	constructor: (@key) ->
		super("keyUp")

#################################################
# an XCDelayAction simply waits for a specified
# amount of time.
#
#################################################
class XCDelayAction extends XCIntervalAction
	# create an XCDelayAction with duration, the 
	# desired amount of time, in seconds, to wait
	constructor: (duration) ->
		super(duration, 'XCDelayAction')
#################################################
# an XCCallFunc action is a one hit action that
# calls a function when it fires
#
#################################################
class XCCallFuncAction extends XCAction
	# create an XCCallFuncAction with the desired function,
	# @fn
	constructor: (@fn) ->
		super("XCCallFuncAction")
	
	#when the action is fired, @fn is called and then the
	# action requests to be removed by returning false. 
	tick: (dt) ->
		@fn()
		return false
#########################################
# XCButtonNode is an image based button
# it automatically listens for taps and
# responds to those which start and end
# within its boundaries.  
#########################################
class XCButtonNode extends XCSpriteNode
	#create a new button with an image
	constructor: (imageName) ->
		super(imageName)
		
		#automatically listen for tap events
		xc.addEventListener('tapDown', this)
		xc.addEventListener('tapUp', this)
		xc.addEventListener('tapMoved', this)
	
	# when a tap is detected	
	tapDown: (event) ->
		# is the tap within the button's boundary?
		if xc.rectContainsPoint(this.rect(), event.point)
			#if so, a tap is starting
			@tapStarted = true
			#call the function onTapStart.  This is useful
			# for visual changes to the button.  For example,
			# growing or changing color.  
			this.onTapStart(event.point)
	
	#when a tap move is detected		
	tapMoved: (event) ->
		#is the tap still within the button's boundaries?
		if not xc.rectContainsPoint(this.rect(), event.point)
			#if not, call the onTapLeave method.  Again,
			# this is useful for visual changes to notify
			# the user that the tap left the button
			this.onTapLeave(event.point)
	
	#when a tap is lifted		
	tapUp: (event) ->
		#did the tap start in our boundaries and is it still there?
		if @tapStarted and xc.rectContainsPoint(this.rect(), event.point)
			#if so, call the onHit function
			this.onHit(event.point)
		#since we just handled the tap, there should be no more.
		@tapStarted = false
	
	#by default, the tapstart and tapleave methods don't do anything
	onTapStart: (point) ->	
	onTapLeave: (point) ->
		
	#by default, the onHit method doesn't do anything.
	onHit: (point) ->
		
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
		


