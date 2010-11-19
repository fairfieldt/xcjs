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
