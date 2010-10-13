xc_node = require '../xc_node'
testCoords = ->
	node = new xc_node.XCNode()
	test1 = false
	test2 = false	
	node.setX(100)
	if node.X() == 100
		console.log("setX OK")
		test1 = true
	node.setY(10)
	if node.Y() == 100
		console.log("setY OK")
		test2 = true
	
	if test1 and test2
		return true
	else
		return false

if testCoords()
	console.log("testCoords OK")
else
	console.log("testCoords failed")
