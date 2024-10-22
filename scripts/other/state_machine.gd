extends Node

@export var initial_state : State

var current_state : State
var states = {}


func _ready():
	# Append child nodes in lowercase, easier to handle.
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
	
	# If haven't switched to initial state at start, do so.
	if initial_state and current_state != initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta):
	if current_state:
		current_state.update(delta)


func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)


func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	# If new state does not exist, stop.
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		return
	
	# Otherwise, exit current state.
	if current_state:
		current_state.exit()
	
	# Go to the new state, set it as current.
	new_state.enter()
	current_state = new_state
