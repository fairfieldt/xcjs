sprites = []
oldX = 0
oldY = 0
tapDown = false

_loadSprite = (imageName) ->
	sprite = new Image()
	sprite.src = imageName
	return sprite
	
_draw = (node) ->

	if node.visible
		context.save()
		if node.drawable
			node.draw(context)
		for child in node.children
			_draw(child)
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
	node.X

_xcNodeY = (node) ->
	node.y
	
_xcNodeColor = (node) ->
	node.color

_xcNodeScaleX = (node) ->
	node.scaleX
	
_xcNodeScaleY = (node) ->
	node.scaleY

_xcNodeRotation = (node) ->
	node.rotation
	
_xcNodeOpacity = (node) ->
	node.opacity
	
_xcNodeAnchorX = (node) -> 
	node.anchorX

_xcNodeAnchorY = (node) -> 
	node.anchorY

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
		currentScene.update(delta)
		clear()
		xc.draw(currentScene)

	clear = -> context.clearRect(0, 0, 640, 480)

	fps = 60
	setInterval(update, 1000/fps)



xc = new xc()
xc_init()
