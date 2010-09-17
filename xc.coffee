class xc
	constructor: ->
		@scenes = []
		@scenes.push new XCScene()
	loadSprite: (imageName, width, height, frameCount) ->
		console.log('loading sprite')
		return new Sprite(imageName, width, height, frameCount, 1)

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
		@scenes.pop().close()
		@scenes.push(newScene)
		
	pushScene: (scene) ->
		scenes.push(scene)
		
	popScene: ->
		@scenes.pop()
		
	getCurrentScene: -> 
		@scenes[@scenes.length-1]

	

		
		
