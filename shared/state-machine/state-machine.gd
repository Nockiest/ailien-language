class_name StateMachine
extends Node



# THIS IS THE DEFAULT STATEMACHIEN EXTEND IT TO USE IT IN OTHER COMPOENTNS!

 
 
# Emitted when transitioning to a new state.
signal transitioned(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
@export var initial_state := NodePath()

# The current active state. At the start of the game, we get the `initial_state`.
@onready var state: State = get_node(initial_state)


func init() -> void:
	for child in get_children():
		child.state_machine = self
		child.owner = get_parent()
	state.enter()

#	var initial_state_node = get_node_or_null(initial_state)
#	if initial_state_node and initial_state_node is State:
#		state = initial_state_node
#	else:
#		print("Error: Initial state is not defined or not a State instance.")
#		# Here you could set a default state or handle the error
#		state = get_node("Idle")  # This is a hypothetical function to set a default state
#
#	# Assign the state machine to each state
#	for child in get_children():
#		if child is State:
#			print("adding statemachine to", child, get_node(initial_state))
#			child.state_machine = self
#
#	print("Initial state:", state)
#	state.enter()
 
 


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(_delta: float) -> void:
	state.update(_delta)


#func _physics_process(_delta: float) -> void:
#	state.physics_update(_delta)


# This function calls the current state's exit() function, then changes the active state,
# and calls its enter function.
# It optionally takes a `msg` dictionary to pass to the next state's enter() function.
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	# Safety check, you could use an assert() here to report an error if the state name is incorrect.
	# We don't use an assert here to help with code reuse. If you reuse a state in different state machines
	# but you don't want them all, they won't be able to transition to states that aren't in the scene tree.
	if not has_node(target_state_name):
		return

	state.exit()
	state = get_node(target_state_name)
	state.enter( msg )
	emit_signal("transitioned", state.name)
