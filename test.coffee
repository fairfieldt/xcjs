canvas = document.getElementById('gameCanvas')

context = canvas.getContext('2d')

$(canvas).mousedown(_xcHandleMouseDown)
$(canvas).mousemove(_xcHandleMouseMoved)
$(canvas).mouseup(_xcHandleMouseUp)

xc = new xc()

root = xc.getCurrentScene()

class BobSprite extends XCSpriteNode
	constructor: ->
		super('bob.png', 34, 48, 1)
	sayHi: ->
		@message = "Hi!"
		alert(@message)

bob = new BobSprite('bob.png')

	
bob.tapMoved = (event) ->
	this.moveBy(event.moveX, event.moveY)
	this.rotateBy(1)
	this.scaleTo(2.0)
	
bob.tapUp = (event) ->
	this.scaleBy(2.0)
	
console.log('got here')

xc.addEventListener('tapMoved', bob)


bad = new XCEvent('doesntExist')
xc.dispatchEvent(bad)

root.addChild(bob)
bob.moveBy(60, 60)

date = new Date()
previousTime = date.getTime()
update =  ->
	currentTime = new Date().getTime()
	delta = currentTime - previousTime
	previousTime = currentTime
	root.update(delta)
	clear()
	xc.draw(root)

clear = -> context.clearRect(0, 0, 640, 480)

fps = 60
setInterval(update, 1000/fps)
