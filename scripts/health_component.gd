extends Node
class_name HealthComponent

@export var health : int
@export var max_health : int

func damage(attack: Attack):
	var state_machine = get_parent().get_node("StateMachine")
	health -= attack.attack_damage
	
	if health <= 0:
		var death_state = ""
		
		match get_parent().name:
			"Player" : death_state = "PlayerDeath"
			"Enemy" : death_state = "EnemyDeath"
		
		print(state_machine.get_children(), "  ", death_state)
		
		if death_state != "" and death_state in state_machine.get_children():
			pass
			#state_machine.on_child_transition(state_machine.current_state, death_state)
	
	else:
		var hit_state = ""
		
		match get_parent().name:
			"Player" : hit_state = "PlayerTakeDMG"
			"Enemy" : hit_state = "EnemyTakeDMG"
		
		print(state_machine.get_children(), "  ", hit_state)
		
		if hit_state != "" and hit_state in state_machine.get_children():
			pass
			#state_machine.on_child_transition(state_machine.current_state, hit_state)
	
