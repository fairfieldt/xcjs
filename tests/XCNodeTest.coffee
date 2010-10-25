#= require XCNode

#=require XCAction

testCoord = ->
	node = new XCNode()
	
	test1 = assert(node.X() == 0 and node.Y() == 0, 'X and Y not 0 on initialization.')
		
	node.setX(5)
	test2 = assert(node.X() == 5, 'setX')
	
	node.setY(5)
	test3 = assert(node.Y() == 5, 'setY')
		
	node.moveBy(5, 0)
	test4 = assert(x = node.X() == 10 and y = node.Y() == 5, 'moveBy')
	
	node.moveBy(-11, -3)
	test5 = assert(x = node.X() == -1 and y = node.Y() == 2, 'moveBy negative')
	
	passed = test1 and test2 and test3 and test4 and test5
	if passed
		console.log('Node coordinate tests OK.')
	else
		console.log('Node coordinate tests Failed.')
	return passed

testLayer = ->
	node = new XCNode()

	test1 = assert(layer = node.layer() == 0, 'intial layer is not 0')
		
	node.setLayer(3)
	test2 = assert(layer = node.layer() == 3, 'setLayer')
		
	passed = test1 and test2
	if passed
		console.log('Node layer tests OK.')
	else
		console.log('Node layer tests Failed.')
	return passed

testColor = ->
	node = new XCNode()
	
	color = node.color() 
	test1 = assert(color.r == 0 and color.g == 0 and color.b == 0, 'initial color')
	
	node.setColor(new XCColor(128, 128, 128))
	color = node.color()
	
	test2 = assert(color.r == 128 and color.g == 128 and color.b == 128, 'setColor')
		
	passed = test1 and test2
	if passed
		console.log('Node color tests OK.')
	else
		console.log('Node color tests Failed.')
	return passed

testScale = ->
	node = new XCNode()
	
	test1 = assert(node.scaleX() == 1.0 and node.scaleY() == 1.0, 'intial scale is not 1.0,1.0')
		
	node.setScaleX(.5)
	test2 = assert(node.scaleX() == .5, 'setScaleX')
	
	node.setScaleY(.5)
	test3 = assert(node.scaleY() == .5, 'setScaleY')
	
	node.scaleTo(1.0)
	test4 = assert(node.scaleX() == 1.0 and node.scaleY() == 1.0, 'scaleTo')

	node.scaleXTo(2.0)
	test5 = assert(node.scaleX() == 2.0, 'scaleXTo')
	
	node.scaleYTo(2.0)
	test6 = assert(node.scaleY() == 2.0, 'scaleYTo')
	
	node.scaleBy(.5)
	test7 = assert(node.scaleX() == 1.0 and node.scaleY() == 1.0, 'scaleBy')
	
	node.scaleXBy(10)
	test8 = assert(node.scaleX() == 10.0, 'scaleXBy')
	
	node.scaleYBy(.2)
	test9 = assert(node.scaleY() == .2, 'scaleYBy')
	
	passed = test1 and test2 and test3 and test4 and test5 and test6 and test7 and test8 and test9
	if passed
		console.log('Node scale tests OK.')
	else
		console.log('Node scale tests Failed.')
	
	return passed
	
testRotation = ->
	node = new XCNode()
	
	test1 = assert(node.rotation() == 0, 'initial rotation not 0')
	
	node.rotateTo(180)
	test2 = assert(node.rotation() == 180, 'rotateTo')
	
	node.rotateBy(95)
	test3 = assert(node.rotation() == 275, 'rotateBy')
	
	node.rotateBy(90)
	test4 = assert(node.rotation() == 5, 'rotateBy wrapping')
	
	node.rotateTo(-90)
	test5 = assert(node.rotation() == 270, 'rotateTo negative wrapping')
	
	passed = test1 and test2 and test3 and test4 and test5
	
	if passed
		console.log('Node rotation tests Ok.')
	else
		console.log('Node rotation tests Failed')
	
	return passed
	
testOpacity = ->
	node = new XCNode()
	
	test1 = assert(node.opacity() == 1.0, 'initial opacity not 1.0')
	
	node.fadeTo(.5)
	test2 = assert(node.opacity() == .5, 'fadeTo')
	
	passed = test1 and test1
	if passed
		console.log('Node opacity tests OK.')
	else
		console.log('Node opacity tests Failed.')
		
	return passed
	
testAnchor = ->
	node = new XCNode()
	
	test1 = assert(node.anchorX() == .5 and node.anchorY() == .5, ' initial anchors not .5')
	
	node.setAnchorX(0)
	test2 = assert(node.anchorX() == 0, 'setAnchorX')
	
	node.setAnchorY(0)
	test3 = assert(node.anchorY() == 0, 'setAnchorY')
	
	passed = test1 and test2 and test3
	if passed
		console.log('Node anchor tests OK.')
	else
		console.log('Node anchor tests Failed.')
		
	return passed
	
testVisibility = ->
	node = new XCNode()
	
	test1 = assert(node.visible() == true, 'node not visible on creation')
	
	node.hide()
	test2 = assert(node.visible() == false, 'hide')
	
	node.hide()
	test3 = assert(node.visible() == false, 'double hide')
	
	node.show()
	test4 = assert(node.visible() == true, 'show')
	
	passed = test1 and test2 and test3 and test4
	if passed
		console.log('Node visibility tests OK.')
	else
		console.log('Node visibility tests Failed.')
	
	return passed
	
testActions = ->
	node = new XCNode()
	
	a1 = new XCAction('a1')
	a2 = new XCAction('a2')
	
	node.runAction(a1)
	test1 = assert(node.actions().length == 1, 'addAction')
	
	node.runAction(a2)
	test2 = assert(node.actions().length == 2, 'addAction 2')
	
	node.removeAction(a1)
	test3 = assert(node.actions().length == 1, 'removeAction')
	
	test4 = assert(node.actions()[0].name == 'a2', 'removeAction did not remove the correct action')
	
	node.runAction(a2)
	test5 = assert(node.actions().length == 1, 'added an action twice')
	
	passed = test1 and test2 and test3 and test4 and test5
	
	if passed
		console.log('Node actions tests OK.')
	else
		console.log('Node action tests Failed.')
	
nodeTests = ->
	testCoord()
	testLayer()
	testColor()
	testScale()
	testRotation()
	testOpacity()
	testAnchor()
	testVisibility()
	testActions()