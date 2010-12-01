########################################################
# XCScene objects are the base on-screen element.  
# Like a flip chart, they can be pushed, popped and
# replaced.  
#######################################################
class XCScene 
	# a scene is given a name to identify it
	constructor: (@name) ->
		
		#these underscore prefixed variables are,
		#by convention private.  
		@_paused = false
		@_children = []
		@_scheduledFunctions = []
	
	#pause the scene.  Actions stop running.
	#TODO: make this work so input is still processed (I think it is)
	#and drawing still happens.  (I think it does)
	pause: ->
		@_paused = true
	
	#paused will return true if the scene is paused, false otherwise
	paused: -> @_paused
	
	#resume the scene.  All actions are started again.
	resume: ->
		@_paused = false
	
	#close is called when a scene is removed.  Cleanup, particularly
	#implementation specific, should happen here.
	close: ->
	
	#tick is called once per frame.  dt is the time in milliseconds
	#since it was called last.
	tick: (dt) ->
		#check for collisions
		children = this.children()
		#console.log('starting at ' + children.length)
		while children.length > 0
		#	console.log('now ' + children.length)
			firstChild = children[0]
			children = children[1...]
			for child in children
		#		console.log('checking...')
		#		console.log(firstChild.rect())
		#		console.log(child.rect())
				if xc.rectContainsRect(firstChild.rect(), child.rect())
					collisionEvent = new XCEvent('CollisionEvent')
					collisionEvent.nodes = [firstChild, child]
					xc.dispatchEvent(collisionEvent)
			
		#for all of the children XCNodes, call their tick function.
		for child in this.children()
			child.tick(dt)
		
		#for all scheduled functions		
		for scheduled in @_scheduledFunctions
			#add the dt to the total elapsed time since the scheduled 
			#function was called.
			scheduled.et += dt
			# is the elapsed time at least the scheduled interval for 
			#this function?
			if scheduled.et >= scheduled.interval
				#if so, call the function
				scheduled.function(scheduled.et)
				#and reset its elapsed time to 0
				scheduled.et = 0
	
	#add an XCNode as a child to this scene.  Children are drawn and updated by the active scene
	#child is an XCNode to add	
	addChild: (child) ->
		#does the child already have a parent?
		unless child.parent() == null
			#if so, throw a DuplicateChildError.  Nodes can only be on one scene ata  time.
			throw {name: 'DuplicateChildError', message:'Node already a child of another scene'}
		#is the child already on the list of children?
		if @_children.indexOf(child) == -1
			#if not, add it
			@_children.push(child)
			# and open it.
			child.open()
			child.setParent(this)
		else
			#otherwise throw a DuplicateChildError.  The node is already this scene's child.
			throw {name:'DuplicateChildError', message:'Can\'t add the same child twice'}
			
	#remove a child from the scene.  
	#child should be an XCNode that is a child of this scene.
	removeChild: (child) ->
		pos = @_children.indexOf(child)
		#is the child on the list of children?
		if pos != -1
			#if so, remove it
			@_children = @_children[0...pos].concat(@_children[pos+1...@_children.length])
			#and close it
			child.close()
		else
			#otherwise throw a NodeNotChildError.  You tried to remove a node that wasn't this scene's child.
			throw {name:'NodeNotChildError', message:'Can\'t remove a node that is not a child'}
	
	#getter for the scene's children.
	#returns an array of XCNodes		
	children: ->
		@_children
	
	#getter for the scene's scheduled functions.
	#returns an array of functions.	
	scheduledFunctions: -> @_scheduledFunctions
	
	#schedule a function, fn, to be called at an interval, interval, in seconds	
	schedule: (fn, interval) ->
		#if no interval is passed, this function should be called every frame
		interval ?= 0
		#add a scheduledFunction object to the list.
		#function is the function to be called, interval is the frequency with which to call it,
		# and et is the elapsed time which will accumulate every frame.
		this.scheduledFunctions().push({function:fn, interval:interval, et:0})
	
	#unschedule a function, fn, from this scene.
	unschedule: (fn) ->
		fnObject = null
		for scheduled in this.scheduledFunctions()
			if scheduled.function == fn
				fnObject = scheduled
				break
		i = this.scheduledFunctions().indexOf(fnObject)
		# is the function scheduled?  
		unless i == -1
			#if so, remove it
			@_scheduledFunctions = @_scheduledFunctions[0...i].concat(@_scheduledFunctions[i+1..@scheduledFunctions.length-1])
		else
			#TODO should throw an exception here
