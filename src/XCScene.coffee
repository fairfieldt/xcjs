########################################################
# XCScene objects are the base on-screen element.  
# Like a flip chart, they can be pushed, popped and
# replaced.  
#######################################################
class XCScene 
	constructor: ->
		@_paused = false
		@_children = []
	pause: ->
		@_paused = true
	
	paused: -> @_paused
	
	resume: ->
		@_paused = false
	
	close: ->
		
	addChild: (child) ->
		@children.push(child)
		child.parent = this

	removeChild: (child) ->
		pos = @children.indexOf(child)
		if pos != -1
			@children = @children[0...pos].concat(@children[pos+1...@children.length])
			child.parent = null