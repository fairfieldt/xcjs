
class XCSequenceAction extends XCAction
	constructor: (@actions) ->
		super("XCSequenceAction")
		
	tick: (dt) ->
		if @actions.length == 0
			return false
		currentAction = @actions[0]
		if not currentAction.tick(dt)
			@actions = @actions[1..@actions.length]
		return true
		
	# here the sequence action acts a bit like an xcnode.
	# it lets actions remove themselves
	removeAction: (action) ->
		position = @actions.indexOf(action)
		if position != -1
			@actions = @actions[0...position].concat(@actions[position+1..@actions.length-1])
	
	# since all of the actions in the sequence need to be owned by the owner of the sequence,
	# do that here.				
	setOwner: (owner) ->
		super(owner)
		for action in @actions
			action.setOwner(@owner)