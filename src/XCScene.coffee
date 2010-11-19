########################################################
# XCScene objects are the base on-screen element.  
# Like a flip chart, they can be pushed, popped and
# replaced.  
#######################################################
class XCScene 
	constructor: (@name) ->
		@_paused = false
		@_children = []
		@_scheduledFunctions = []
	pause: ->
		@_paused = true
	
	paused: -> @_paused
	
	resume: ->
		@_paused = false
	
	close: ->
	
	tick: (dt) ->
		for child in this.children()
			child.tick(dt)
				
		for scheduled in @_scheduledFunctions
			scheduled.et += dt
			if scheduled.et >= scheduled.interval
				scheduled.function(scheduled.et)
				scheduled.et = 0
		
	addChild: (child) ->
		unless child.parent == null
			throw {name: 'DuplicateChildError', message:'Node already a child of another scene'}
		if @_children.indexOf(child) == -1
			@_children.push(child)
			child.parent = this
		else
			throw {name:'DuplicateChildError', message:'Can\'t add the same child twice'}

	removeChild: (child) ->
		pos = @_children.indexOf(child)
		if pos != -1
			@_children = @_children[0...pos].concat(@_children[pos+1...@_children.length])
			child.parent = null
		else
			throw {name:'NodeNotChildError', message:'Can\'t remove a node that is not a child'}
			
	children: ->
		@_children
		
	scheduledFunctions: -> @_scheduledFunctions
		
	schedule: (fn, interval) ->
		interval ?= 0
		@_scheduledFunctions.push({function:fn, interval:interval, et:0})
		
	unschedule: (fn) ->
		i = @_scheduledFunctions.indexOf(fn)
		
		unless i == -1
			@_scheduledFunctions = @_scheduledFunctions[0..i].concat(@_scheduledFunctions[i+1..@scheduledFunctions.length])
