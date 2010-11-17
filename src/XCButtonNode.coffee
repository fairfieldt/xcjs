###############################
# XCButtonNode
#
###############################

class XCButtonNode extends XCSpriteNode
	constructor: (imageName) ->
		super(imageName)
		xc.addEventListener('tapDown', this)
		xc.addEventListener('tapUp', this)
		xc.addEventListener('tapMoved', this)
		
	tapDown: (event) ->
		if xc.rectContainsPoint(this.rect(), event.point)
			@tapStarted = true
			this.scaleTo(1.1)
			
	tapMoved: (event) ->
		if not xc.rectContainsPoint(this.rect(), event.point)
			@tapStarted = false
			this.scaleTo(1.0)
			
	tapUp: (event) ->
		if @tapStarted and xc.rectContainsPoint(this.rect(), event.point)
			if this.onHit
				this.onHit()
				this.scaleTo(1.0)
		@tapStarted = false
