class XCRunForeverAction extends XCAction
	constructor: (@action, tag) ->
		super('XCRunForeverAction', tag)
		
	tick: (dt) ->
		@action.tick(dt)


	# since all of the actions in the sequence need to be owned by the owner of the sequence,
	# do that here.				
	setOwner: (owner) ->
		super(owner)
		@action.setOwner(@owner)
