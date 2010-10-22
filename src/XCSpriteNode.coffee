##########################################################
# XCSpriteNode is an XCNode with an image
# to create an XCSpriteNode, give the constructor an image
# and its width and height.  TODO: I may remove the width
# and height requirement
#########################################################
class XCSpriteNode extends XCNode
	constructor: (imageName, @width, @height) ->
		@drawable = true
		super()
		@sprite = _xcLoadSprite(imageName)
		@frame = 0

	draw: ->
		_xcSpriteDraw(this)