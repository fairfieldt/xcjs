class xc
	constructor: ->
	loadSprite: (spriteName) ->
		return _loadSprite(spriteName)

	draw: (node) ->
		_draw(node)

	getSpriteWidth: (sprite) ->
		return sprite.width
	getSpriteHeight: (sprite) ->
		return sprite.height
		
	addEventListener: (eventName, listener) ->
		if not this[eventName]
			this[eventName] = []
		this[eventName].push(listener)
		
	dispatchEvent: (event) ->
		for listener in this[event.name]
			if listener[event.name](event)
				break

		
		