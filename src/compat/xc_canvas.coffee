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
	wasPaused = false
	
	update =  ->
		currentTime = new Date().getTime()
		delta = (currentTime - previousTime) / 1000
		previousTime = currentTime
		currentScene = xc.getCurrentScene()
		
		if currentScene.paused()
			wasPaused = true
			return
		else
			if wasPaused
				delta = 0
				wasPaused = false
			for child in currentScene.getChildren()
				for action in child.getActions()
					action.tick(delta)
			
		clear()
		_xcDraw(currentScene)

	clear = -> context.clearRect(0, 0, 640, 480)

	fps = 60
	setInterval(update, 1000/fps)


$(xc = new xc()
xc_init())
