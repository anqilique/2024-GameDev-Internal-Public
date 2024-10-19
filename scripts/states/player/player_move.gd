extends State
class_name PlayerMove

var player
var rig_animator
var mask_data

func enter():
	player = get_tree().get_first_node_in_group("Player")
	rig_animator = player.get_node("AnimationPlayer")
	mask_data = MaskVars.get_mask_from_num()
	
	player.get_node("AnimationPlayer").play("move")
	player.get_node("Rig/CPUParticles3D").emitting = true

func exit():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	# Handle jump.
	if Input.is_action_pressed("ui_accept") and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerJump")

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var movement_speed = PlayerVars.base_speed + mask_data["movement_speed_bonus"]
	
	if direction:  # Move in that direction.
		player.velocity.x = direction.x * movement_speed
		player.velocity.z = direction.z * movement_speed
		
		if rig_animator.current_animation != "move":
			rig_animator.play("move")
		
	else:  # Stop the player.
		player.velocity.x = move_toward(player.velocity.x, 0, movement_speed)
		player.velocity.z = move_toward(player.velocity.z, 0, movement_speed)
		
	# If not moving, switch to idle.
	if direction == Vector3(0, 0, 0) and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerIdle")

	player.move_and_slide()
