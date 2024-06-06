extends Node
class_name HealthComponent

@export var health : int
@export var max_health : int

func damage(attack: Attack):
	var state_machine = get_parent().get_node("StateMachine")
	health -= attack.attack_damage
	
	print("	-->	", health, " / ", max_health)
	
	if health <= 0:
		var death_state = ""
		
		match get_parent().name:
			"Player" : death_state = "PlayerDeath"
			"Enemy" : death_state = "EnemyDeath"
		
		if death_state != "" and state_machine.has_node(death_state):
			state_machine.on_child_transition(state_machine.current_state, death_state)
		else:
			print("Need to create state!")
	
	
	else:
		var hit_state = ""
		
		match get_parent().name:
			"Player" : hit_state = "PlayerTakeDMG"
			"Enemy" : hit_state = "EnemyTakeDMG"
		
		if hit_state != "" and state_machine.has_node(hit_state):
			state_machine.on_child_transition(state_machine.current_state, hit_state)
		else:
			print("Need to create state!")
	
