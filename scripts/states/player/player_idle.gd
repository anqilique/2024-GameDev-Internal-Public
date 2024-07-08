extends State
class_name PlayerIdle

var player
var rig_animator
var mask_data

func enter():
	player = get_tree().get_first_node_in_group("Player")
	rig_animator = player.get_node("Rig/player_basic/AnimationPlayer")
	mask_data = load(PlayerVars.masks[PlayerVars.current_mask])
	
	print(rig_animator.get)

func update(_delta):
	if (  # If any of the horizontal movement keys are pressed.
		Input.is_action_pressed("ui_left") or 
		Input.is_action_pressed("ui_right") or
		Input.is_action_pressed("ui_up") or
		Input.is_action_pressed("ui_down") or
		Input.is_action_pressed("ui_accept")
	):
		get_parent().on_child_transition(self, "PlayerMove")
	

func physics_update(_delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerJump")
	
	var movement_speed = PlayerVars.base_speed + mask_data.movement_speed_bonus
	
	# Slow the player down once if they're not jumping.
	player.velocity.x = move_toward(player.velocity.x, 0, movement_speed)
	player.velocity.z = move_toward(player.velocity.z, 0, movement_speed)
	
	if rig_animator.current_animation != "idle ":
		rig_animator.play("idle ")
	
	player.move_and_slide()
