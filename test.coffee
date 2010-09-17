canvas = document.getElementById('gameCanvas')

context = canvas.getContext('2d')

$(canvas).mousedown(_xcHandleMouseDown)
$(canvas).mousemove(_xcHandleMouseMoved)
$(canvas).mouseup(_xcHandleMouseUp)

xc = new xc()
root = new XCNode()

class BobSprite
	constructor: ->
		super('bob.png')
	sayHi: ->
		@message = "Hi!"
		alert(@message)

bob = new BobSprite('bob.png')
bob.onUpdate = (delta) ->
	#@x += .06 * delta
	#this.scaleBy(1.1)

bob.tapDown = (event) ->
#	this.moveTo(event.x, event.y)
	return true
	
bob.tapMoved = (event) ->
	this.moveBy(event.moveX, event.moveY)
	
bob.tapUp = (event) ->
	this.scaleBy(1.5)
	
xc.addEventListener('tapMoved', bob)
	
xc.addEventListener('tapDown', bob)

#xc.addEventListener('tapUp', bob)

bad = new XCEvent('doesntExist')
xc.dispatchEvent(bad)

man2 = new XCSpriteNode('bob.png') 

man2.testEvent = (event) -> 
	this.scaleBy(.5) 
	return false
xc.addEventListener('testEvent', man2)


event = []
event.name = 'testEvent'
xc.dispatchEvent(event)


root.addChild(man2)

man2.moveTo(300, 400)
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
