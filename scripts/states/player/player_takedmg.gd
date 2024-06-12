extends State
class_name PlayerTakeDMG

const DAMAGED_SPEED = 8

var player

func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.get_node("RecoveryTimer").start()  # Time spent in this state.

func physics_update(_delta):  # Allow the player to move, but slower.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	player.velocity.x = move_toward(player.velocity.x, direction.x * DAMAGED_SPEED, PlayerVars.speed)
	player.velocity.z = move_toward(player.velocity.z, direction.z * DAMAGED_SPEED, PlayerVars.speed)
	
	player.move_and_slide()
