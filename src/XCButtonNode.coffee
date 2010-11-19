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
		