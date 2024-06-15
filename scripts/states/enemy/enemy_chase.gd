extends State
class_name EnemyChase

const SPEED = 3

var enemy
var player
var moving

var nav_agent

func enter():
	enemy = get_parent().get_parent()
	
	nav_agent = enemy.get_node("NavigationAgent3D")

func exit():
	# Slow down to a velocity of zero.
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, 12)
	enemy.velocity.z = move_toward(enemy.velocity.z, 0, 12)
	
	enemy.move_and_slide()

func update(_delta):
	nav_agent.set_target_position(player.global_transform.origin)

func physics_update(_delta):
	player = get_tree().get_first_node_in_group("Player")
	
	if player.get_node("StateMachine").current_state.name != "PlayerDeath":
		var current_location = enemy.global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * SPEED
		
		enemy.velocity = new_velocity
		enemy.move_and_slide()
		
		enemy.get_node("Rig").look_at(player.global_transform.origin, Vector3.UP)
		enemy.get_node("Vision3D").look_at(player.global_transform.origin, Vector3.UP)
