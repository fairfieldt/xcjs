class SpriteNode extends Node
	constructor: (imageName) ->
		super()
		@sprite = xc.loadSprite(imageName)
		@width =  xc.getSpriteWidth(@sprite)
		@height = xc.getSpriteHeight(@sprite)


