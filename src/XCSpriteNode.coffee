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
