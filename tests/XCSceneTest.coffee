#= require <CoffeeSpec>
#= require XCNode

describe 'XCScene',
	beforeEach ->
		@scene2 = new XCScene('Scene2')
		
	it 'starts with no children', ->
		expect(@scene2._children).toHaveLength(0)
		
	it 'adds a child', ->
		child = new XCNode()
		@scene2.addChild(child)
		expect(@scene2.children()).toHaveLength(1)
		
	it 'removes a child', ->
		child = new XCNode()
		@scene2.addChild(child)
		@scene2.removeChild(child)
		expect(@scene2.children()).toHaveLength(0)
		
	it 'removes the right child', ->
		child1 = new XCNode()
		child2 = new XCNode()
		@scene2.addChild(child1)
		@scene2.addChild(child2)
		@scene2.removeChild(child2)
		
		expect(@scene2.children()[0]).toEqual(child1)
		
	it 'shouldn\'t remove a node that is not a child', ->
		child = new XCNode()
		expect(=>@scene2.removeChild(child)).toThrow('NodeNotChildError')
		
	it 'shouldn\'t add the same node twice', ->
		child = new XCNode()
		@scene2.addChild(child)
		expect(=>@scene2.addChild(child)).toThrow('DuplicateChildError')
		
	it 'shouldn\'t add a node that is a child of another scene', ->
		child = new XCNode()
		@scene3 = new XCScene('Scene2')
		@scene3.addChild(child)
		expect(=>@scene2.addChild(child)).toThrow('DuplicateChildError')