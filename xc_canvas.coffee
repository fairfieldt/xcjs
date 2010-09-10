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
