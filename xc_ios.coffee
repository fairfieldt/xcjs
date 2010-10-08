sprites = []
oldX = 0
oldY = 0
tapDown = false
gcCounter = 0

_xcLoadSprite = (imageName) ->
	xc_load_sprite(imageName, 0)
	
_xcDraw = (node) ->
	if node.drawable and node.dirty
		console.log("drawing")
		node.draw()
	for child in node.children
		_xcDraw(child)

_xcHandleMouseDown = (event) ->
	x = event.x
	y = event.y

	tapDown = true
	
	e = new XCTapDownEvent(x, y, 0)
	xc.dispatchEvent(e)
	
_xcHandleMouseUp = (event) ->
	tapDown = false
	x = event.x
	y = event.y
	
	e = new XCTapUpEvent(x, y, 0)
	xc.dispatchEvent(e)
	
_xcHandleMouseMoved = (event) ->
	if tapDown
		x = event.x
		y = event.y
		moveX = event.moveX
		moveY = event.moveY

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
	node.x

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
	
	tapEvent = xc_get_tap()
	while tapEvent != null
		if tapEvent.name == 'tapDown'
			_xcHandleMouseDown(tapEvent)
		else if tapEvent.name == 'tapMoved'
			_xcHandleMouseMoved(tapEvent)
		else if tapEvent.tname == 'tapUp'
			_xcHandleMouseUp(tapEvent)
		tapEvent = xc_get_tap()
	
	for action in xc.actions	
		action.tick(delta)
	console.log("draw batch start")
	_xcDraw(currentScene)
	console.log("draw batch end")
	if gcCounter++ > 30
		xc_gc()


xc = new xc()
console = []
