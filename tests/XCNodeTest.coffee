#= require XCNode

node = new XCNode()

coordTests ->
	passed = true
	
	if node.X() == 0 and node.Y() == 0
		console.log('Initial X and Y OK')
	else
		passed = false
		console.log('Fail: X and Y not 0 on initialization.')
		
	node.setX(5)
	if x = node.X() == 5
		console.log('setX OK')
	else
		passed = false
		console.log('Fail: setX.  Expected 5 - got ' + x)
		
	node.setY(5)
	if y = node.Y() == 5
		console.log('setY OK')
	else
		passed = false
		console.log('Fail: setY.  Expected 5 - got ' + y)
		
	node.moveBy(5, 0)
	if x = node.X() == 10 and y = node.Y() == 5
		console.log('moveBy OK')
	else
		passed = false
		console.log('Fail: moveBy.  Expected 10,5 - got ' + x + ',' + y)
		
	node.moveBy(-11, -3)
	if x = node.X() == -1 and y = node.Y() == 2
		console.log('moveBy OK')
	else
		passed = false
		console.log('Fail: moveBy negative.  Expected -1,2 - got ' + x + ',' + y)

nodeTests ->
	coordTests()