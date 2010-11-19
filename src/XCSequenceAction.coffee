##############################################
# an XCSequenceAction is an action that
# runs a list of XCActions serially.
##############################################
class XCSequenceAction extends XCAction
	#to create an XCSequenceAction, give it an array of the actions
	# it should run.
	constructor: (@actions) ->
		super("XCSequenceAction")
		
	tick: (dt) ->
		# are there any actions left?
		if @actions.length == 0
			#if not, this action is done.
			return false
		#otherwise, get the first one.
		currentAction = @actions[0]
		#and run it.  Is the current action done?
		if not currentAction.tick(dt)
			# if so, remove it from the list.
			@actions = @actions[1..@actions.length]
		#keep running.
		return true
	
	# since all of the actions in the sequence need to be owned by the owner of the sequence,
	# do that here.				
	setOwner: (owner) ->
		super(owner)
		for action in @actions
			action.setOwner(@owner)