#########################################################
# XCTextNode is an XCNode that displays text
# You can set the fontName and fontsize at initialization
# and change the text at any time. 
#########################################################
class XCTextNode extends XCNode
	constructor: (@_text, @fontName, @fontSize) ->
		#since a TextNode is drawable, set this to trude
		@drawable = true
		
		#@ref is the reference to the text node.
		# it's implementation specific and, as such
		# is loaded by an _xc function.  Some implementations
		# may not use it at all.
		@sprite = _xcLoadText(this)
		
		#store the font as needed by the canvas implementation
		#TODO: move this to a better place.
		@font = @fontSize + "pt " + @fontName
		super()
	
	#getters for the width and height.
	#these need to be different than the
	#generic node getters because of the
	#canvas implementation.  	
	width: -> _xcTextNodeWidth(this)
	
	height: -> _xcTextNodeHeight(this)

	#getter and setter for the node text.
	# these will change or get the text that is
	# displayed by this node. They call the 
	#implementation specific _xc functions.
	text: -> _xcTextNodeText(this)

	setText: (newText) ->
		_xcTextSetText(this, newText)		
	
	#draw is called every frame for @drawable nodes	
	draw: ->
		#to draw a TextNode, call the implementation
		#specific _xcTextDraw.
		_xcTextDraw(this)
