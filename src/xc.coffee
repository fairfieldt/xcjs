#######################################################
# the xc object is the controller for an xc application
# it provides an extensible event system with input
# events and scene management.
######################################################

#= require XCScene

class xc
	constructor: ->
		@scenes = []
		@scenes.push new XCScene('DefaultScene')

	addEventListener: (eventName, listener) ->
		if not @[eventName]
			@[eventName] = []
		if @[eventName].indexOf(listener) == -1
			@[eventName].push(listener)
		else
			throw {name:'EventListenerAlreadyAddedError', message: 'The event listener for ' + eventName + ' ' + listener + ' was already added'}
		
	removeEventListener: (eventName, listener) ->
		if @[eventName]? and pos = @[eventName].indexOf(listener) != -1
			@[eventName] = @[eventName][0...pos].concat(@[eventName][pos+1...@[eventName].length]) 
		else
			throw {name:'NoSuchEventListenerError', message:'There is no listener for ' + eventName + ' ' + listener}
			
		
		
	dispatchEvent: (event) ->
		if @[event.name]?
			for listener in @[event.name]
				listener[event.name](event)

	replaceScene: (newScene) ->
		unless newScene == this.getCurrentScene()
			@scenes.pop().close()
			@scenes.push(newScene)
		else
			throw {name:'DuplicateSceneError', message:'Cannot replace a scene with itself'}
	pushScene: (scene) ->
		if @scenes.indexOf(scene) == -1
			@scenes.push(scene)
		else
			throw {name:'DuplicateSceneError', message:'Cannot put a scene on the stack twice'}
		
	popScene: ->
		if @scenes.length > 1
			@scenes.pop().close()
		else
			throw {name:'PoppedLastSceneError', message:'Can\'t pop with one scene left'}
		
	getCurrentScene: -> 
		@scenes[@scenes.length-1]
		




		
