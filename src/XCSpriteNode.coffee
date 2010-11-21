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
		
		#load the image with the implementation specific _xc function.
		@sprite = _xcLoadImage(imageName)
		
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
