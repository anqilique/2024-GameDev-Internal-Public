extends State
class_name EnemyAttack

@export var attack_cooldown : float

var enemy

func enter():
	enemy = get_parent().get_parent()
	enemy.get_node("AttackTimer").wait_time = attack_cooldown

func update(_delta):
	if enemy.get_node("AttackTimer").is_stopped():  # If not on cooldown.
		
		var hitbox
		
		if enemy.has_node("Rig/Hitbox3D"):
			hitbox = enemy.get_node("Rig/Hitbox3D")
		else:
			hitbox = enemy.get_node("Hitbox3D")
		
		for body in hitbox.get_overlapping_bodies():
			
			# If the player is detected.
			if body.has_node("HurtboxComponent") and body.name == "Player":
				
				# And if the player is not dead.
				if body.get_node("StateMachine").current_state.name != "PlayerDeath":
					var hurtbox = body.get_node("HurtboxComponent")
					var attack = Attack.new()
					
					# Attack the player's hurtbox.
					attack.attack_damage = 10
					hurtbox.damage(attack)
					
					# Start cooldown timer.
					enemy.get_node("AttackTimer").start()
					
				else:
					# Randomize time spent in next state.
					enemy.reset_statetimer()
					
					# Return to the idle state.
					var state_machine = enemy.get_node("StateMachine")
					state_machine.on_child_transition(state_machine.current_state, "EnemyIdle")
