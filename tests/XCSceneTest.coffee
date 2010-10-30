#= require <xc>
#= require <CoffeeSpec>

describe 'xc',
	beforeEach ->
		@xc = new xc()
		@scene2 = new XCScene('Scene2')
		
	it 'has a default scene', ->
		expect(@xc.getCurrentScene()).notToEqual(undefined)
		
	it 'replaces a scene', ->
		@xc.replaceScene(@scene2)
		expect(@xc.getCurrentScene().name).toEqual('Scene2') and
		expect(@xc.scenes.length).toEqual(1)
		
	it 'pushes a scene', ->
		@xc.pushScene(@scene2)
		expect(@xc.getCurrentScene().name).toEqual('Scene2') and
		expect(@xc.scenes.length).toEqual(2)
		
	it 'pops a scene', ->
		@xc.pushScene(@scene2)
		@xc.popScene()
		expect(@xc.getCurrentScene().name).toEqual('DefaultScene') and
		expect(@xc.scenes.length).toEqual(1)
		
	it 'shouldn\'t pop the last scene', ->
		expect(=>@xc.popScene()).toThrow('PoppedLastSceneError')
		
	it 'shouldn\'t push a scene that is already on the stack', ->
		@xc.pushScene(@scene2)
		expect(=>@xc.pushScene(@scene2)).toThrow('DuplicateSceneError')
	
	it 'shouldn\'t replace a scene with itself', ->
		@xc.pushScene(@scene2)
		expect(=>@xc.replaceScene(@scene2)).toThrow('DuplicateSceneError')