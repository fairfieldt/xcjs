#########################################################
# XCTextNode is an XCNode that displays text
# You can set the fontName and fontsize at initialization
# and change the text at any time. 
#########################################################
class XCTextNode extends XCNode
	constructor: (@_text, @fontName, @fontSize) ->
		@drawable = true
		@ref = _xcLoadText(this)
		
		super()

	text: -> _xcTextNodeText(this)

	setText: (newText) ->
		_xcTextSetText(this, newText)		
		
	draw: ->
		_xcTextDraw(this)