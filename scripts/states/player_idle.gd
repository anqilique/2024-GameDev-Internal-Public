extends State
class_name PlayerIdle

var player

func enter():
	player = get_tree().get_first_node_in_group("Player")

func update(delta):
	if (  # If any of the horizontal movement keys are pressed.
		Input.is_action_pressed("ui_left") or 
		Input.is_action_pressed("ui_right") or
		Input.is_action_pressed("ui_up") or
		Input.is_action_pressed("ui_down") or
		Input.is_action_pressed("ui_accept")
	):
		get_parent().on_child_transition(self, "PlayerMove")

func physics_update(delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerJump")
	
	# Slow the player down once if they're not jumping.
	player.velocity.x = move_toward(player.velocity.x, 0, 12)
	player.velocity.z = move_toward(player.velocity.z, 0, 12)
	
	player.move_and_slide()
