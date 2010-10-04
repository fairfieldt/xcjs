sprites = []
oldX = 0
oldY = 0
tapDown = false

_xcLoadSprite = (imageName) ->
	xc_load_sprite(imageName, 0)
	
_draw = (node) ->
	if node.drawable
		node.draw()
	for child in node.children
		_draw(child)

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
	
_xcSpriteDraw = (node) ->
	xc_update_sprite(node.sprite, node.x, node.y, node.scaleX, node.scaleY, node.rotation, node.opacity, node.anchorX, node.anchorY)
	
_xcTextDraw = (node) ->
	#stub

xc_init = ->
	xc_print("xc_init called")	
	
	console.log = (text) -> xc_print(text)
	onLoad()

	date = new Date()
	previousTime = date.getTime()
xc_update = (delta) ->
	currentScene = xc.getCurrentScene()
	currentScene.update(delta)
	xc.draw(currentScene)
	xc_gc()


xc = new xc()
console = []
