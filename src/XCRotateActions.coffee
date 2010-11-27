#####################################################
# XCRotateAction is the base rotate action.  It shouldn't
# be used by itself, instead use one of its children:
# XCRotateToAction or XCRotateByAction
####################################################
class XCRotateAction extends XCIntervalAction
	#create an XCRotateAction with duration, the time in seconds to run
	# and name, the name of the action.  
	constructor: (duration, name, tag) ->
		super(duration, name, tag)
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
	constructor: (duration, @angle, tag) ->
		super(duration, "XCRotateTo", tag)
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
	constructor: (duration, @angle, tag) ->
		super(duration, "XCRotateBy", tag)
		#calculate the degrees to rotate per second
		@stepAngle = @angle / @duration
		
		#positiveRotation tells whether we're rotating in a positive or
		#negative direction.  This is needed to prevent overrotation.
		@positiveRotation = @angle > 0
