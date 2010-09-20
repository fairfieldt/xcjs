sprites = []
oldX = 0
oldY = 0
tapDown = false
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


xc_init = ->
	window.canvas = document.getElementById('gameCanvas')

	window.context = canvas.getContext('2d')

	$(canvas).mousedown(_xcHandleMouseDown)
	$(canvas).mousemove(_xcHandleMouseMoved)
	$(canvas).mouseup(_xcHandleMouseUp)


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
