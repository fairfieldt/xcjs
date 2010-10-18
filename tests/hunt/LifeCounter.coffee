class LifeCounter extends XCNode
	constructor: (@lifeCount) ->
		super()
		@man = new XCSpriteNode('resources/dude.png', 16, 16)
		this.addChild(@man)
		@man.moveTo(10,352)
		
		lifeString = 'x' + @lifeCount
		@lifeCounter = new XCTextNode(lifeString, 'Helvetica', 12)
		
		this.addChild(@lifeCounter)
		@lifeCounter.moveTo(30, 365)
		
	addLife: ->
		@lifeCount += 1
		this.update()
		
	removeLife: ->
		@lifeCount -= 1
		this.update()
		if @lifeCount <= 0
			xc.dispatchEvent(new XCEvent('GameOver'))
		
		
	update: ->
		lifeString = 'x' + @lifeCount
		@lifeCounter.setText(lifeString)
		  
		