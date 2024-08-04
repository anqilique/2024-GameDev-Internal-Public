extends State
class_name EnemyTakeDMG

const DAMAGED_SPEED = 0.08
const SPEED = 0.1

var enemy

func enter():
	enemy = get_parent().get_parent()
	
	var recovery_timer = enemy.get_node("RecoveryTimer")
	recovery_timer.start()
	
	print("Ouch Damage!")


func _on_recovery_timer_timeout():
	var state_machine = enemy.get_node("StateMachine")
	var hitbox
		
	# Hitboxes differ between enemy types. Get right one.
	if enemy.has_node("Rig/Hitbox3D"):
		hitbox = enemy.get_node("Rig/Hitbox3D")
	else:
		hitbox = enemy.get_node("Hitbox3D")
	
	if hitbox.get_overlapping_bodies() != []:
		for body in hitbox.get_overlapping_bodies():
			# If the player is detected.
			if body.has_node("HurtboxComponent") and body.name == "Player":
				var player_state = body.get_node("StateMachine").current_state.name
				
				# Don't bother attacking if the player is dead.
				if player_state == "PlayerDeath": return
				
				# If player is alive, then attack.
				state_machine.on_child_transition(state_machine.current_state, "EnemyAttack")
			
	else: state_machine.on_child_transition(state_machine.current_state, "EnemyIdle")
