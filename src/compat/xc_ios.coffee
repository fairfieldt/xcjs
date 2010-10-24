sprites = []
oldX = 0
oldY = 0
tapDown = false
gcCounter = 0

_xcLoadSprite = (imageName) ->
	xc_load_sprite(imageName, 0)
	
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
############################ are now in obj-c code##########################

	
_xcTextDraw = (node) ->
	#stub

xc_init = ->
	xc_print("xc_init called")	
	
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
		else if tapEvent.name == 'tapUp'
			_xcHandleMouseUp(tapEvent)
		tapEvent = xc_get_tap()
	
	for action in xc.actions	
		action.tick(delta)

	if gcCounter++ > 30
		xc_gc()


xc = new xc()
console = []
