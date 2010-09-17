sprites = []
oldX = 0
oldY = 0
tapDown = false
_draw = (node) ->

	if node.visible

		if node.sprite
			node.sprite.Draw(context)
			
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
	
