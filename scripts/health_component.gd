extends Node
class_name HealthComponent

@export var health : int
@export var max_health : int

func damage(attack: Attack):
	# Get the state machine of the parent node.
	var state_machine = get_parent().get_node("StateMachine")
	health -= attack.attack_damage
	
	print("	-->	", health, " / ", max_health)
	
	# If player, update the global variables as well.
	if get_parent().name == "Player":
		PlayerVars.current_health = health
	
	if health <= 0:  # If health is less than 1, parent node 'dies'.
		var death_state = ""
		
		match get_parent().get_groups()[0]:
			"Player" : death_state = "PlayerDeath"
			"Enemies" : death_state = "EnemyDeath"
		
		# If parent node has a death state, switch to the state.
		if death_state != "" and state_machine.has_node(death_state):
			state_machine.on_child_transition(state_machine.current_state, death_state)
	
	
	else:  # If there is enough health left to survive.
		var hit_state = ""
		
		match get_parent().get_groups()[0]:
			"Player" : hit_state = "PlayerTakeDMG"
			"Enemies" : hit_state = "EnemyTakeDMG"
		
		# If a hit state exists, switch to it.
		if hit_state != "" and state_machine.has_node(hit_state):
			state_machine.on_child_transition(state_machine.current_state, hit_state)
	
