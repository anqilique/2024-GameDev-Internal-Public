extends State
class_name PlayerTakeDMG

const SLOW_MULTIPLIER = 0.8

var player
var enemy
var mask_data

func enter():
	player = get_node("/root/Main/Player")
	player.get_node("RecoveryTimer").start()  # Time spent in this state.
	mask_data = MaskVars.get_mask_from_num()
	
	var colliders = player.get_node("Hurtbox3D").get_overlapping_bodies()
	
	if colliders != []:
		enemy = player.get_node("Hurtbox3D").get_overlapping_bodies()[0]
	
		player.velocity = (player.global_transform.origin - enemy.global_transform.origin).normalized()
		player.velocity *= 5
		player.velocity.y = 5


func physics_update(_delta):  # Allow the player to move, but slower.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var movement_speed = PlayerVars.base_speed + mask_data["movement_speed_bonus"]
	
	if player.get_node("RecoveryTimer").is_stopped():
		player.velocity.x = direction.x * movement_speed * SLOW_MULTIPLIER
		player.velocity.z = direction.z * movement_speed * SLOW_MULTIPLIER
	
	player.move_and_slide()
