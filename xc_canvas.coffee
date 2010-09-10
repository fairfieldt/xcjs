sprites = []

_draw = (node) ->

	if node.visible

		context.save()
		if node.sprite
			parentX = if node.parent then node.parent.x else 0
			parentY = if node.parent then node.parent.y else 0
			destinationX = Math.floor((node.width * node.anchorX) + node.x + parentX)
			destinationY = Math.floor((node.height * node.anchorY) + node.y + parentY)

			sizeX = Math.floor(node.scaleX * node.width)
			sizeY = Math.floor(node.scaleY * node.height)
			
			context.drawImage(node.sprite, destinationX, destinationY, sizeX, sizeY)

		for child in node.children
			_draw(child)

_loadSprite = (spriteName) ->
	sprite = null
	if sprites[spriteName]?
		sprite = sprites[spriteName]
	else
		sprite = new Image()
		sprite.src = spriteName

		while !sprite.complete
			continue
		sprites[spriteName] = sprite
	
	return sprite
	
_xcHandleMouseDown = (event) ->
	x = event.pageX
	y = event.pageY
	alert('a mouse down at ' + x + "," + y)
	e = new XCTapDownEvent(0, 0, 0)
	xc.dispatchEvent(e)