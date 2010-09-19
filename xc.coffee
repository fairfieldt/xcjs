class xc
	constructor: ->
		@scene = new XCScene()
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
		if this[event.name]?
			for listener in this[event.name]
				if listener[event.name](event)
					break

	replaceScene: (newScene) ->
		@scene.close()
		@scene = newScene

	

		
		
