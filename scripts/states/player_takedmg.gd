extends State
class_name PlayerTakeDMG

var player

func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.get_node("RecoveryTimer").start()

func physics_update(delta):
	# Slow the player down once if they're not jumping.
	player.velocity.x = move_toward(player.velocity.x, 0, 12)
	player.velocity.z = move_toward(player.velocity.z, 0, 12)
	
	player.move_and_slide()
