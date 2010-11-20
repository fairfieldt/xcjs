###
Copyright 2010 Tom Fairfield. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY TOM FAIRFIELD ``AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of Tom Fairfield.
###
sprites = []
oldX = 0
oldY = 0
tapDown = false

_xcLoadSprite = (imageName) ->
	sprite = null
	endsWith = new RegExp('/' + imageName + '$')
	for image in document.images		
		if image.src.match(endsWith)
			sprite = image
	return sprite
	
_xcImageWidth = (sprite) ->
	sprite.width

_xcImageHeight = (sprite) ->
	sprite.height
	
_xcLoadText = (node) ->
	return null
	
_xcDraw = (node) ->
	if node.visible()
		context.save()
		node.draw()
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
	context.translate(node.X(), node.Y())

	context.rotate(node.rotation() * Math.PI / 180)
	context.globalAlpha = node.opacity()
	
	fillStyle = 'rgb(' + node.color().r + ',' + node.color().g + ',' + node.color().b + ')'
	context.fillStyle = fillStyle

	context.drawImage(node.sprite, 
					0,
					0,
					node.sprite.width, 
					node.sprite.height, 
					0 - (node.width() * node.anchorX()), 
					0 - (node.height() * node.anchorY()), 
					node.sprite.width * node.scaleX(), 
					node.sprite.height * node.scaleY())
	
_xcTextDraw = (node) ->
	node.font = node.fontSize + "pt " + node.fontName
	context.font = node.font
	fillStyle = 'rgb(' + node.color().r + ',' + node.color().g + ',' + node.color().b + ')'
	context.fillStyle = fillStyle
	context.translate(node.X(), node.Y())
						
	context.rotate(node.rotation() * Math.PI / 180)
	context.scale(node.scaleX(), node.scaleY())
	context.globalAlpha = node.opacity()
	
	context.fillText(node.text(), 0 - (node.width() * node.anchorX()),
									0 - (node.height() * node.anchorY()))


itemLoaded = (item)->
	if --itemsToLoad <= 0
		xc_init()
	
xc_init = ->
	window.canvas = document.getElementById('gameCanvas')
	
	window.context = canvas.getContext('2d')

	$(canvas).mousedown(_xcHandleMouseDown)
	$(canvas).mousemove(_xcHandleMouseMoved)
	$(canvas).mouseup(_xcHandleMouseUp)
	$(document).keydown(_xcHandleKeyDown)
	$(document).keyup(_xcHandleKeyUp)


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
			currentScene.tick(delta)
			clear()
			for child in currentScene.children()
					_xcDraw(child)

	clear = -> context.clearRect(0, 0, canvasWidth, canvasHeight)

	fps = 60
	setInterval(update, 1000/fps)


$(xc = new xc())
