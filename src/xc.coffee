#######################################################
# the xc object is the controller for an xc application
# it provides an extensible event system with input
# events and scene management.
######################################################

#= require XCScene

class xc
	constructor: ->
		@scenes = []
		@scenes.push new XCScene()

	addEventListener: (eventName, listener) ->
		if not @[eventName]
			@[eventName] = []
		@[eventName].push(listener)
		
	removeEventListener: (eventName, listener) ->
			if pos = @[eventName].indexOf(listener) != -1
				@[eventName] = @[eventName][0...pos].concat(@[eventName][pos+1...@[eventName].length]) 
		
		
	dispatchEvent: (event) ->
		if @[event.name]?
			for listener in @[event.name]
				listener[event.name](event)

	replaceScene: (newScene) ->
		@scenes.pop().close()
		@scenes.push(newScene)
		
	pushScene: (scene) ->
		scenes.push(scene)
		
	popScene: ->
		@scenes.pop()
		
	getCurrentScene: -> 
		@scenes[@scenes.length-1]
		




		
