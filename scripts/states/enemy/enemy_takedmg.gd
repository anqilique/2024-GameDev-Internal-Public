extends State
class_name EnemyTakeDMG

const DAMAGED_SPEED = 0.08
const SPEED = 0.1
const JUMP_VELOCITY = 4.5

var enemy
var player
var velocity


func enter():
	enemy = get_parent().get_parent()
	player = get_node("/root/Main/Player")
	
	var recovery_timer = enemy.get_node("RecoveryTimer")
	recovery_timer.start()
	
	# Knock the enemy back in opposite direction.
	enemy.velocity = (enemy.global_transform.origin - player.global_transform.origin).normalized()
	enemy.velocity *= 10
	enemy.velocity.y = 5
	
	AudioHandler.play_sound("Impact")


func _on_recovery_timer_timeout():
	var state_machine = enemy.get_node("StateMachine")
	var hitbox
	
	velocity = Vector3.ZERO
		
	# Hitboxes differ between enemy types. Get right one.
	if enemy.has_node("Rig/Hitbox3D"):
		hitbox = enemy.get_node("Rig/Hitbox3D")
	else:
		hitbox = enemy.get_node("Hitbox3D")
	
	# If bodies are in range.
	if hitbox.get_overlapping_bodies() != []:
		for body in hitbox.get_overlapping_bodies():
			
			# Check if the body is the player's.
			if body.has_node("HurtboxComponent") and body.name == "Player":
				var player_state = body.get_node("StateMachine").current_state.name
				
				# Don't bother attacking if the player is dead.
				if player_state == "PlayerDeath":
					return
				
				# If player is alive, then attack.
				state_machine.on_child_transition(state_machine.current_state, "EnemyAttack")
			
	else:  # If nothing is in range, go to idling.
		state_machine.on_child_transition(state_machine.current_state, "EnemyIdle")
