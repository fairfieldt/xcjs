########################################################
# XCScene objects are the base on-screen element.  
# Like a flip chart, they can be pushed, popped and
# replaced.  
#######################################################
class XCScene 
	constructor: (@name) ->
		@_paused = false
		@_children = []
	pause: ->
		@_paused = true
	
	paused: -> @_paused
	
	resume: ->
		@_paused = false
	
	close: ->
		
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