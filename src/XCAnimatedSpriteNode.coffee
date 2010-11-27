class XCAnimatedSpriteNode extends XCSpriteNode
	constructor: (imageName, width, height, @_padding) ->
		super(imageName)
		@_width = (width)
		@_height = (height)
		@_frameWidth = width
		@_frameHeight = height
		
	
