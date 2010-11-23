#=require <CoffeeSpec>

#= require XCNode

#=require XCAction

describe "XCNode", 

	beforeEach ->
		@node = new XCNode()
		
	it 'starts with x == 0', ->
		expect(@node.X()).toEqual(0)
		
	it 'starts with y == 0', ->
		expect(@node.Y()).toEqual(0)
		
	it 'sets x to 5', ->
		@node.setX(5)
		expect(@node.X()).toEqual(5)
		
	it 'sets y to 5', ->
		@node.setY(5)
		expect(@node.Y()).toEqual(5)
		
	it 'moves node by 5,0', ->
		@node.moveBy(5, 0)
		expect(@node.X()).toEqual(5) and
		expect(@node.Y()).toEqual(0)
	
	it 'moves node by -1,-2', ->
		@node.moveBy(-1,-2)
		expect(@node.X()).toEqual(-1) and
		expect(@node.Y()).toEqual(-2)

	it 'starts with layer == 0', ->
		expect(@node.layer()).toEqual(0)
		
	it 'sets layer to 3', ->
		@node.setLayer(3)
		expect(@node.layer()).toEqual(3)
		
	it 'sets layer to -1', ->
		@node.setLayer(-1)
		expect(@node.layer()).toEqual(-1)

	it 'starts with color white', ->
		@color = @node.color()
		expect(@color.r).toEqual(0xFF) and
		expect(@color.g).toEqual(0xFF) and
		expect(@color.b).toEqual(0xFF)
	
	it 'sets color to grey', ->
		@node.setColor(new XCColor(128,128,128))
		@color = @node.color()
		expect(@color.r).toEqual(128) and
		expect(@color.g).toEqual(128) and
		expect(@color.b).toEqual(128)

	it 'starts with scaleX 1.0', ->
		expect(@node.scaleX()).toEqual(1.0)
	
	it 'starts with scaleY 1.0', ->
		expect(@node.scaleY()).toEqual(1.0)
		
	it 'sets scaleX to .5', ->
		@node.setScaleX(.5)
		expect(@node.scaleX()).toEqual(.5)
		
	it 'sets scaleY to .5', ->
		@node.setScaleY(.5)
		expect(@node.scaleY()).toEqual(.5)
		
	it 'scales X to 1.5', ->
		@node.scaleXTo(1.5)
		expect(@node.scaleX()).toEqual(1.5)
		
	it 'scales Y to 1.1', ->
		@node.scaleYTo(1.1)
		expect(@node.scaleY()).toEqual(1.1)
		
	it 'scaleTo 2.0', ->
		@node.scaleTo(2.0)
		expect(@node.scaleX()).toEqual(2.0) and
		expect(@node.scaleY()).toEqual(2.0)

	it 'scales X by 10', ->
		@node.scaleXBy(10)
		expect(@node.scaleX()).toEqual(10.0)
	
	it 'scales Y by 4', ->
		@node.scaleYBy(4)
		expect(@node.scaleY()).toEqual(4.0)
	
	it 'scales by 2', ->
		@node.scaleBy(2)
		expect(@node.scaleX()).toEqual(2.0) and
		expect(@node.scaleY()).toEqual(2.0)
		
	it 'starts with rotation 0', ->
		expect(@node.rotation()).toEqual(0)
		
	it 'rotates to 180', ->
		@node.rotateTo(180)
		expect(@node.rotation()).toEqual(180)
	
	it 'rotates by 90 from 10', ->
		@node.rotateTo(10)
		@node.rotateBy(90)
		expect(@node.rotation()).toEqual(100)
		
	it 'rotates by 370, wrapping to 10', ->
		@node.rotateBy(370)
		expect(@node.rotation()).toEqual(10)
		
	it 'rotates to -90, wrapping to 270', ->
		@node.rotateTo(-90)
		expect(@node.rotation()).toEqual(270)
	
	it 'starts with opacity of 1.0', ->
		expect(@node.opacity()).toEqual(1.0)
	
	it 'fades to .5', ->
		@node.fadeTo(.5)
		expect(@node.opacity()).toEqual(.5)
		
	it 'fades to -0.2, leaving opacity of 0', ->
		@node.fadeTo(-.2)
		expect(@node.opacity()).toEqual(0)
	
	it 'fades to 1.5, leaving opacity of 1.0', ->
		@node.fadeTo(1.5)
		expect(@node.opacity()).toEqual(1.0)
		
	it 'starts with anchorX at 0.5', ->
		expect(@node.anchorX()).toEqual(0.5)
	
	it 'starts with anchorY at 0.5', ->
		expect(@node.anchorY()).toEqual(0.5)
		
	it 'sets anchorX to 0.0', ->
		@node.setAnchorX(0.0)
		expect(@node.anchorX()).toEqual(0.0)
		
	it 'sets anchorY to -1.0', ->
		@node.setAnchorY(-1.0)
		expect(@node.anchorY()).toEqual(-1.0)
	
	it 'starts with visible true', ->
		expect(@node.visible()).toEqual(true)
		
	it 'hides', ->
		@node.hide()
		expect(@node.visible()).toEqual(false)
		
	it 'hides twice, leaving invisible', ->
		@node.hide()
		@node.hide()
		expect(@node.visible()).toEqual(false)
		
	it 'shows', ->
		@node.hide()
		@node.show()
		expect(@node.visible()).toEqual(true)
	
	it 'shows while visible, leaving still visible', ->
		@node.show()
		expect(@node.visible()).toEqual(true)

	it 'starts without any actions', ->
		expect(@node.actions()).toHaveLength(0)
	
	it 'runs an action', ->
		@node.runAction(new XCAction('a1'))
		expect(@node.actions()).toHaveLength(1)
	
	it 'runs two actions', ->
		@node.runAction(new XCAction('a1'))
		@node.runAction(new XCAction('a2'))
		expect(@node.actions()).toHaveLength(2)
		
	it 'removes the only action', ->
		a1 = new XCAction('a1')
		@node.runAction(a1)
		@node.removeAction(a1)
		expect(@node.actions()).toHaveLength 0
	
	it 'removes an action, leaving one', ->
		a1 = new XCAction('a1')
		a2 = new XCAction('a2')
		@node.runAction(a1)
		@node.runAction(a2)
		@node.removeAction(a2)
		expect(@node.actions()[0]).toEqual(a1)
	
	it 'removes an action when its not owned by the object', ->
		a1 = new XCAction('a1')
		expect(=>@node.removeAction(a1)).toThrow('RemoveActionError')
		
	it 'runs an action twice', ->
		a1 = new XCAction('a1')
		@node.runAction(a1)
		expect(=>@node.runAction(a1)).toThrow('RunDuplicateActionError')
