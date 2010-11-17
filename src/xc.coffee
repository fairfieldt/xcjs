#######################################################
# the xc object is the controller for an xc application
# it provides an extensible event system with input
# events and scene management.
######################################################

#= require XCScene

class xc
	constructor: ->
		@_scenes = []
		@_scenes.push new XCScene('DefaultScene')

	addEventListener: (eventName, listener) ->
		if not @[eventName]
			@[eventName] = []
		if @[eventName].indexOf(listener) == -1
			@[eventName].push(listener)
		else
			throw {name:'EventListenerAlreadyAddedError', message: 'The event listener for ' + eventName + ' ' + listener + ' was already added'}
		
	removeEventListener: (eventName, listener) ->
		if @[eventName]? and (pos = @[eventName].indexOf(listener)) != -1
			@[eventName] = @[eventName][0...pos].concat(@[eventName][pos+1..@[eventName].length-1])
		else
			throw {name:'NoSuchEventListenerError', message:'There is no listener for ' + eventName + ' ' + listener}
		
		
		
	dispatchEvent: (event) ->
		if @[event.name]?
			for listener in @[event.name]
				listener[event.name](event)

	replaceScene: (newScene) ->
		unless newScene == this.getCurrentScene()
			@_scenes.pop().close()
			@_scenes.push(newScene)
		else
			throw {name:'DuplicateSceneError', message:'Cannot replace a scene with itself'}
	pushScene: (scene) ->
		if @_scenes.indexOf(scene) == -1
			@_scenes.push(scene)
		else
			throw {name:'DuplicateSceneError', message:'Cannot put a scene on the stack twice'}
		
	popScene: ->
		if @_scenes.length > 1
			@_scenes.pop().close()
		else
			throw {name:'PoppedLastSceneError', message:'Can\'t pop with one scene left'}
		
	getCurrentScene: -> 
		@_scenes[@_scenes.length-1]
		

	rectContainsPoint: (rect, point) ->
		(point.x > rect.x) and (point.x < (rect.x + rect.w)) and
		(point.y > rect.y) and (point.y < (rect.y + rect.h))
		
