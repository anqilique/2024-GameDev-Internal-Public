extends State
class_name PlayerTakeDMG

const SLOW_MULTIPLIER = 0.5

var player
var mask_data

func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.get_node("RecoveryTimer").start()  # Time spent in this state.
	
	mask_data = load(PlayerVars.masks[PlayerVars.current_mask])

func physics_update(_delta):  # Allow the player to move, but slower.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	var movement_speed = PlayerVars.base_speed + mask_data.movement_speed_bonus
	
	player.velocity.x = direction.x * movement_speed * SLOW_MULTIPLIER
	player.velocity.z = direction.z * movement_speed * SLOW_MULTIPLIER
	
	player.move_and_slide()
