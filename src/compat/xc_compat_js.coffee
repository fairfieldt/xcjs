################# XCNode platform specific implementations #################
class XCCompat
	constructor: ->
		
_xcNodeWidth = (node) ->
	node.width
	
_xcNodeHeight = (node) ->
	node.height

_xcNodeX = (node) ->
	node._x

_xcNodeY = (node) ->
	node._y

_xcNodeSetX = (node, newX) ->
	node._x = newX

_xcNodeSetY = (node, newY) ->
	node._y = newY
	
_xcNodeLayer = (node) ->
	node._layer
	
_xcNodeSetLayer = (node, newLayer) ->
	node._layer = newLayer

_xcNodeColor = (node) ->
	node._color

_xcNodeSetColor = (node, newColor) ->
	node._color = newColor

_xcNodeScaleX = (node) ->
	node._scaleX

_xcNodeScaleY = (node) ->
	node._scaleY

_xcNodeSetScaleX = (node, newScaleX) ->
	node._scaleX = newScaleX

_xcNodeSetScaleY = (node, newScaleY) ->
	node._scaleY = newScaleY

_xcNodeRotation = (node) ->
	node._rotation

_xcNodeSetRotation = (node, newRotation) ->
	while newRotation > 360
		newRotation = newRotation - 360
	while newRotation < 0
		newRotation = 360 + newRotation
	node._rotation = newRotation
	
_xcNodeOpacity = (node) ->
	node._opacity

_xcNodeSetOpacity = (node, newOpacity) ->
	if newOpacity < 0
		newOpacity = 0
	else if newOpacity > 1.0
		newOpacity = 1.0
	
	node._opacity = newOpacity
	
_xcNodeAnchorX = (node) -> 
	node._anchorX

_xcNodeAnchorY = (node) -> 
	node._anchorY

_xcNodeSetAnchorX = (node, newAnchorX) ->
	node._anchorX = newAnchorX

_xcNodeSetAnchorY = (node, newAnchorY) ->
	node._anchorY = newAnchorY
	
_xcNodeVisible = (node) ->
	node._visible
	
_xcNodeSetVisible = (node, visible) ->
	node._visible = visible

_xcTextNodeText = (node) ->
	node._text

_xcTextSetText = (node, newText) ->
	node._text = newText
