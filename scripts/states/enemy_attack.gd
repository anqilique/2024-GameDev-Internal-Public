extends State
class_name EnemyAttack

@export var attack_cooldown : float

var enemy

func enter():
	enemy = get_parent().get_parent()
	enemy.get_node("AttackTimer").wait_time = attack_cooldown

func update(_delta):
	if enemy.get_node("AttackTimer").is_stopped():
		for body in enemy.get_node("Hitbox3D").get_overlapping_bodies():
			if body.has_node("HurtboxComponent") and body.name == "Player":
				
				if body.get_node("StateMachine").current_state.name != "PlayerDeath":
					var hurtbox = body.get_node("HurtboxComponent")
					var attack = Attack.new()
					
					attack.attack_damage = 10
					hurtbox.damage(attack)
					
					enemy.get_node("AttackTimer").start()
					
				else:
					enemy.reset_statetimer()
					
					var state_machine = enemy.get_node("StateMachine")
					state_machine.on_child_transition(state_machine.current_state, "EnemyIdle")
