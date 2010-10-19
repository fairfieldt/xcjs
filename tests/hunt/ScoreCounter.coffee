class ScoreCounter extends XCNode
	constructor: ->
		super()
		@scoreLabel = new XCTextNode('Score: 0', 'Helvetica', 12)
		@score = 0
		this.addChild(@scoreLabel)
		
		@scoreLabel.moveTo(10, 390)
		
		
	addScore: (amount) ->
		@score += amount
		
		newText = 'Score: ' + @score
		
		@scoreLabel.setText(newText)
		
	ScoredPoints: (event) ->
		this.addScore(event.points)