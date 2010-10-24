#= require XCNode


testCoord = ->
	node = new XCNode()

	passed = true
	
	unless node.X() == 0 and node.Y() == 0
		passed = false
		console.log('Fail: X and Y not 0 on initialization.')
		
	node.setX(5)
	if x = node.X() != 5
		passed = false
		console.log('Fail: setX.  Expected 5 - got ' + x)
		
	node.setY(5)
	if y = node.Y() != 5
		passed = false
		console.log('Fail: setY.  Expected 5 - got ' + y)
		
	node.moveBy(5, 0)
	unless x = node.X() == 10 and y = node.Y() == 5
		passed = false
		console.log('Fail: moveBy.  Expected 10,5 - got ' + x + ',' + y)
		
	node.moveBy(-11, -3)
	unless x = node.X() == -1 and y = node.Y() == 2
		passed = false
		console.log('Fail: moveBy negative.  Expected -1,2 - got ' + x + ',' + y)
	
	if passed
		console.log('Node coordinate tests OK.')
	return passed

testLayer = ->
	node = new XCNode()

	passed = true
	
	unless layer = node.layer() == 0
		passed = false
		console.log('Fail: intial layer.  Expected 0 - got ' + layer)
		
	node.setLayer(3)
	unless layer = node.layer() == 3
		passed = false
		console.log('Fail: setLayer.  Expected 3 - got ' + layer)
		
	if passed
		console.log('Node layer tests OK.')
	return passed

testColor = ->
	node = new XCNode()
	passed = true
	
	color = node.color() 
	unless color.r == 0 and color.g == 0 and color.b == 0
		passed = false
		console.log('Fail: color.  Expected 0,0,0 - got ' + color.r + ',' + color.g + ',' + color.b)
	
	node.setColor(new XCColor(128, 128, 128))
	color = node.color()
	
	unless color.r == 128 and color.g == 128 and color.b == 128
		console.log('Fail: setColor.  Expected 128,128,128 - got ' + color.r + ',' + color.g + ',' + color.b)
		
	if passed
		console.log('Node color tests OK.')
	return passed


nodeTests = ->
	testCoord()
	testLayer()
	testColor()