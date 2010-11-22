#######################################################
# the xc object is the controller for an xc application
# it provides an extensible event system with input
# events and scene management.
######################################################

#= require XCScene

class xc
	constructor: ->
		#_scenes is the array of scenes, the last one is the current scene
		@_scenes = []
		#add an empty scene for the default scene
		@_scenes.push new XCScene('DefaultScene')
		@_events = []
	# add an object to listen for an event
	# eventName is the name of the event to listen to
	# and listener is an object that has a method with that name
	addEventListener: (eventName, listener) ->
		# are there currently any listeners for the specified event?
		if not @_events[eventName]
			# if not, make an empty array to hold them
			@_events[eventName] = []
		# is the object already listening for this event?
		if @_events[eventName].indexOf(listener) == -1
			#if not, put it on the array of listeners
			@_events[eventName].push(listener)
		else
			#otherwise throw an EventListenerAlreadyAddedError
			message = 'The event listener for ' + eventName + ' ' + listener +
					' was already added'
			throw {name:'EventListenerAlreadyAddedError', message:message}
	
	#remove an object from the listeners for the specified event
	# eventName is the name of the event to listen to and
	# listener is the object to remove from listeners
	removeEventListener: (eventName, listener) ->
		#are there any listeners for that event and is listener one of them?
		if @_events[eventName]? and (pos = @_events[eventName].indexOf(listener)) != -1
			#if so, remove it.
			@_events[eventName] = @_events[eventName][0...pos].concat(@_events[eventName][pos+1..@_events[eventName].length-1])
		else
			#otherwise throw a NoSuchEventListenerError
			message = 'There is no listener for ' + eventName + ' ' + listener
			throw {name:'NoSuchEventListenerError', message:message}
	clearEvents: ->
		@_events = []

	# given an event, pass it to all of the listeners
	dispatchEvent: (event) ->
		# are there any listeners?
		if @_events[event.name]?
			#if so, call the appropriate handler for each of them.
			for listener in @_events[event.name]
				listener[event.name](event)
	
	# given a scene, replace the current scene with the new scene
	# newScene is an XCScene
	replaceScene: (newScene) ->
		#is newScene on the stack?
		unless @_scenes.indexOf(newScene) != -1
			#if not, close the current scene
			oldScene = @_scenes.pop().close()
			#and replace it with the new scene
			@_scenes.push(newScene)
			return oldScene
		else
			# otherwise throw a DuplicateSceneError.  
			throw {name:'DuplicateSceneError', message:'Cannot replace a scene with itself'}
	
	#given a scene, make it the currentScene.  All scenes currently on the stack
	# are moved back one.
	pushScene: (newScene) ->
		#is newScene on the stack?
		if @_scenes.indexOf(newScene) == -1
			#if not, push it on.  It's now the current scene.
			@_scenes.push(newScene)
		else
			#otherwise throw a DuplicateSceneError
			throw {name:'DuplicateSceneError', message:'Cannot put a scene on the stack twice'}
	
	#remove the current scene from the stack and return it.  
	popScene: ->
		#is there going to be a scene left after removing the current one?
		if @_scenes.length > 1
			#if so, pop it, close it, and return it
			oldScene = @_scenes.pop()
			oldScene.close()
			return oldScene
		else
			#otherwise throw a PoppedLastSceneError.  you can't pop the last scene.
			throw {name:'PoppedLastSceneError', message:'Can\'t pop with one scene left'}
	
	#returns the current XCScene	
	getCurrentScene: -> 
		@_scenes[@_scenes.length-1]
		
	#helper function to determine if a rectangle contains a point.
	# rect is an object {x,y,w,h} and point is an object {x,y}
	rectContainsPoint: (rect, point) ->
		(point.x > rect.x) and (point.x < (rect.x + rect.w)) and
		(point.y > rect.y) and (point.y < (rect.y + rect.h))
		
