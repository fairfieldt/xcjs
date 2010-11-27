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
		
		#load the image with the implementation specific _xc function.
		@sprite = _xcLoadImage(imageName)
		super()
		
		#get the width and height with the 
		#implementation specific _xc functions.
		@_width = _xcImageWidth(this)
		@_height = _xcImageHeight(this)
		
		#The index into the image to draw.  For normal sprites it's always 0.
		#Animated sprites will change this to animate.
		@_frame = 0

	#draw is called every tick for @drawable nodes
	draw: ->
		#to draw the node, call the implementation specific
		# _xcSpriteDraw function.
		_xcSpriteDraw(this)
		
	frameHeight: -> _xcSpriteFrameHeight(this)
	frameWidth: -> _xcSpriteFrameWidth(this)
	
	frame: -> _xcSpriteFrame(this)
	setFrame: (newFrame) -> _xcSpriteSetFrame(this, newFrame)
