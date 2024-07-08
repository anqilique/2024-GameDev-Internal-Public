extends State
class_name PlayerMove

var player
var rig_animator

func enter():
	player = get_tree().get_first_node_in_group("Player")
	rig_animator = player.get_node("Rig/player_basic/AnimationPlayer")

func exit():
	pass

func update(_delta):
	pass

func physics_update(_delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerJump")

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:  # Move in that direction.
		player.velocity.x = direction.x * PlayerVars.speed
		player.velocity.z = direction.z * PlayerVars.speed
		
		if rig_animator.current_animation != "run ":
			rig_animator.play("run ")
		
	else:  # Stop the player.
		player.velocity.x = move_toward(player.velocity.x, 0, PlayerVars.speed)
		player.velocity.z = move_toward(player.velocity.z, 0, PlayerVars.speed)
		
	# If not moving, switch to idle.
	if direction == Vector3(0, 0, 0) and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerIdle")

	player.move_and_slide()
