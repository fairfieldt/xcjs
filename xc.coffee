class xc
	constructor: ->

	loadSprite: (spriteName) ->
		sprite = new Image()
		sprite.src = spriteName
		return sprite

	draw: (node) ->
		_draw(node)

	getSpriteWidth: (sprite) ->
		return sprite.width
	getSpriteHeight: (sprite) ->
		return sprite.height
