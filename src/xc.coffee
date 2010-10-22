#######################################################
# the xc object is the controller for an xc application
# it provides an extensible event system with input
# events and scene management.
######################################################

class xc
	constructor: ->
		@scenes = []
		@scenes.push new XCSceneNode()
		@actions = []

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
		




		
