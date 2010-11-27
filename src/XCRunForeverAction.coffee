class XCRunForeverAction extends XCAction
	constructor: (@action) ->
		super('XCRunForeverAction')
		
	tick: (dt) ->
		@action.tick(dt)

	# since all of the actions in the sequence need to be owned by the owner of the sequence,
	# do that here.				
	setOwner: (owner) ->
		super(owner)
		for action in @actions
			action.setOwner(@owner)
