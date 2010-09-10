canvas = document.getElementById('gameCanvas')

context = canvas.getContext('2d')


xc = new xc()
root = new Node()
bob = new SpriteNode('bob.png')

bob.direction = 1
bob.onUpdate = (delta) ->
	@x += .06 * delta
	#this.scaleBy(1.1)

man2 = new SpriteNode('bob.png')

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
