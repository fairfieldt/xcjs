sprites = []
oldX = 0
oldY = 0
tapDown = false
gcCounter = 0

#drawing is taken care of by the backend.
_xcSpriteDraw = (node) -> 
_xcTextDraw = (node) -> 

handleMouseDown = (event) ->
	x = event.x
	y = event.y

	tapDown = true
	
	e = new XCTapDownEvent(x, y, 0)
	xc.dispatchEvent(e)
	
handleMouseUp = (event) ->
	tapDown = false
	x = event.x
	y = event.y
	
	e = new XCTapUpEvent(x, y, 0)
	xc.dispatchEvent(e)
	
handleMouseMoved = (event) ->
	if tapDown
		x = event.x
		y = event.y
		moveX = event.moveX
		moveY = event.moveY

		e = new XCTapMovedEvent(x, y, moveX, moveY, 0)
		xc.dispatchEvent(e)

#no keys in ios
handleKeyDown = (event) ->
handleKeyUp = (event) ->

################# XCNode platform specific implementations #################
############################ are now in obj-c code##########################


xc_init = ->
	xc_print("xc_init called")	
	console.log = xc_print;
	main()

	date = new Date()
	previousTime = date.getTime()

xc_update = (delta) ->
	currentScene = xc.getCurrentScene()
	
	tapEvent = xc_get_tap()
	while tapEvent != null
		if tapEvent.name == 'tapDown'
			handleMouseDown(tapEvent)
		else if tapEvent.name == 'tapMoved'
			handleMouseMoved(tapEvent)
		else if tapEvent.name == 'tapUp'
			handleMouseUp(tapEvent)
		tapEvent = xc_get_tap()
	
	currentScene.tick(delta)

	if gcCounter++ > 30
		xc_gc()


xc = new XC()
console = []
