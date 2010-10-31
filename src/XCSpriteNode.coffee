##########################################################
# XCSpriteNode is an XCNode with an image
# to create an XCSpriteNode, give the constructor an image
# and its width and height.  TODO: I may remove the width
# and height requirement
#########################################################
class XCSpriteNode extends XCNode
	constructor: (imageName) ->
		@drawable = true
		super()
		@sprite = _xcLoadSprite(imageName)
		@width = _xcImageWidth(@sprite)
		@height = _xcImageHeight(@sprite)
		@frame = 0

	draw: ->
		_xcSpriteDraw(this)