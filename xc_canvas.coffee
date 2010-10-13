sprites = []
oldX = 0
oldY = 0
tapDown = false

_xcLoadSprite = (imageName) ->
	sprite = new Image()
	sprite.src = imageName
	return sprite
	
_xcLoadText = (node) ->
	return null
	
_xcDraw = (node) ->

	if node.visible
		context.save()
		if node.drawable
			node.draw()
		for child in node.children
			_xcDraw(child)
		context.restore()	


_xcHandleMouseDown = (event) ->
	x = event.pageX - canvas.offsetLeft
	y = event.pageY - canvas.offsetTop
	
	oldX = x
	oldY = y
	tapDown = true
	
	e = new XCTapDownEvent(x, y, 0)
	xc.dispatchEvent(e)
	
_xcHandleMouseUp = (event) ->
	tapDown = false
	x = event.pageX - canvas.offsetLeft
	y = event.pageY - canvas.offsetTop
	
	e = new XCTapUpEvent(x, y, 0)
	xc.dispatchEvent(e)
	
_xcHandleMouseMoved = (event) ->
	if tapDown
		x = event.pageX - canvas.offsetLeft
		y = event.pageY - canvas.offsetTop
		moveX = x - oldX
		moveY = y - oldY
		oldX = x
		oldY = y
		e = new XCTapMovedEvent(x, y, moveX, moveY, 0)
		xc.dispatchEvent(e)

_xcHandleKeyDown = (event) ->
	key = event.which
	e = new XCKeyDownEvent(key)
	xc.dispatchEvent(e)

_xcHandleKeyUp = (event) ->
	key = event.which

	e = new XCKeyUpEvent(key)
	xc.dispatchEvent(e)

################# XCNode platform specific implementations #################

_xcNodeX = (node) ->
	node._x

_xcNodeY = (node) ->
	node._y

_xcNodeSetX = (node, newX) ->
	node._x = newX


_xcNodeSetY = (node, newY) ->
	node._y = newY


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
	node._rotation = newRotation
	
_xcNodeOpacity = (node) ->
	node._opacity

_xcNodeSetOpacity = (node, newOpacity) ->
	node._opacity = newOpacity
	
_xcNodeAnchorX = (node) -> 
	node._anchorX

_xcNodeAnchorY = (node) -> 
	node._anchorY

_xcNodeSetAnchorX = (node, newAnchorX) ->
	node._anchorX = newAnchorX

_xcNodeSetAnchorY = (node, newAnchorY) ->
	node._anchorY = newAnchorY

_xcTextSetText = (node, newText) ->
	node.text = newText


	
_xcSpriteDraw = (node) ->
	context.translate(node.X() - (node.X() * node.anchorX()), node.Y() - (node.Y() * node.anchorY()))
	
	context.rotate(node.rotation() * Math.PI / 180)
	context.globalAlpha = node.opacity()

	context.drawImage(node.sprite, 0, 0, node.width, node.height, 0, 0, node.width * node.scaleX(), node.height * node.scaleY())
	
_xcTextDraw = (node) ->
	node.font = node.fontSize + "pt " + node.fontName
	context.font = node.font

	context.translate(node.X() - (node.X() * node.anchorX()), node.Y() - (node.Y() * node.anchorY()))
	context.rotate(node.rotation() * Math.PI / 180)
	context.scale(node.scaleX(), node.scaleY())
	context.globalAlpha = node.opacity()
	
	context.fillText(node.text(), 0, 0)

xc_init = ->
	window.canvas = document.getElementById('gameCanvas')

	window.context = canvas.getContext('2d')

	$(canvas).mousedown(_xcHandleMouseDown)
	$(canvas).mousemove(_xcHandleMouseMoved)
	$(canvas).mouseup(_xcHandleMouseUp)
	$(document).keydown(_xcHandleKeyDown)
	$(document).keyup(_xcHandleKeyUp)


	#load images here

	onLoad()

	date = new Date()
	previousTime = date.getTime()
	update =  ->
		currentTime = new Date().getTime()
		delta = (currentTime - previousTime) / 1000
		previousTime = currentTime
		currentScene = xc.getCurrentScene()
		
		for action in xc.actions
			action.tick(delta)
			
		clear()
		_xcDraw(currentScene)

	clear = -> context.clearRect(0, 0, 640, 480)

	fps = 60
	setInterval(update, 1000/fps)



xc = new xc()
xc_init()
