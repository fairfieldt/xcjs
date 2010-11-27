#####################################################
# XCMoveAction is the base move action.  It shouldn't
# be used by itself, instead use one of its children:
# XCMoveTo and XCMoveBy
####################################################
class XCMoveAction extends XCIntervalAction
	# to create an XCMoveAction, the duration, in seconds,
	# and the name is required.  XCMoveAction objects
	# should never be created directly, only sub-classed.
	constructor: (duration, name, tag) ->
		super(duration, name, tag)
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
	constructor: (duration, @x, @y, tag) ->
		super(duration, "XCMoveTo", tag)
		
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
	constructor: (duration, @x, @y, tag) ->
		super(duration, "XCMoveBy", tag)
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
