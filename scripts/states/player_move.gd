extends State
class_name PlayerMove

const SPEED = 12.0

var player

func enter():
	player = get_tree().get_first_node_in_group("Player")
	

func exit():
	pass

func update(delta):
	pass

func physics_update(delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerJump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:  # Move in that direction.
		player.velocity.x = direction.x * SPEED
		player.velocity.z = direction.z * SPEED
	else:  # Stop the player.
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)
	
	# If not moving, switch to idle.
	if direction == Vector3(0, 0, 0) and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerIdle")

	player.move_and_slide()
