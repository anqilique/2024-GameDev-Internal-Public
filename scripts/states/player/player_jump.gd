extends State
class_name PlayerJump

var jump_count = 0
var can_jump = false
var player

func enter():
	player = get_tree().get_first_node_in_group("Player")

func physics_update(_delta):
	# Handle jump.
	if Input.is_action_pressed("ui_accept") or player.is_on_floor():
		can_jump = true
	
	# If the player is able to jump, and hasn't reached max jumps.
	if can_jump and jump_count < PlayerVars.jump_max_count:
		player.velocity.y = PlayerVars.jump_velocity
		jump_count += 1
	
	player.move_and_slide()
	
	# When player lands, go back to idle unless...
	if player.is_on_floor() and jump_count > 0:
		jump_count = 0
		can_jump = true
		
		get_parent().on_child_transition(self, "PlayerIdle")
	
	if (  # If player is pressing any movement keys.
		Input.is_action_just_pressed("ui_left") or 
		Input.is_action_just_pressed("ui_right") or
		Input.is_action_just_pressed("ui_up") or
		Input.is_action_just_pressed("ui_down")
	):
		jump_count = 0
		can_jump = true
		get_parent().on_child_transition(self, "PlayerMove")
