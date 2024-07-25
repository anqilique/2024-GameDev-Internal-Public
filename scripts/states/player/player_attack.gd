extends State
class_name PlayerAttack

@export var attack_cooldown : float

var player
var rig_animator
var mask_data

func enter():
	player = get_tree().get_first_node_in_group("Player")
	rig_animator = player.get_node("Rig/player_basic/AnimationPlayer")
	mask_data = load(PlayerVars.masks[PlayerVars.current_mask])
	
	# If not already attacking, start an attack.
	if rig_animator.current_animation != "attack":
			rig_animator.play("attack")

func update(_delta):
	if (  # If any of the horizontal movement keys are pressed.
		Input.is_action_pressed("ui_left") or 
		Input.is_action_pressed("ui_right") or
		Input.is_action_pressed("ui_up") or
		Input.is_action_pressed("ui_down") or
		
		# Or if mouse is released.
		Input.is_action_just_released("ui_left_mouse_button")
	):
		get_parent().on_child_transition(self, "PlayerMove")

func physics_update(_delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		get_parent().on_child_transition(self, "PlayerJump")
	
	var movement_speed = PlayerVars.base_speed + mask_data.movement_speed_bonus
	
	player.velocity.x = move_toward(player.velocity.x, 0, movement_speed)
	player.velocity.z = move_toward(player.velocity.z, 0, movement_speed)
	
	player.move_and_slide()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		# Attack all enemies within the player's attack range.
		for body in player.get_node("Rig/Hitbox3D").get_overlapping_bodies():
			if body.has_node("HurtboxComponent") and body.is_in_group("Enemies"):
				var hurtbox = body.get_node("HurtboxComponent")
				var attack = Attack.new()
				
				attack.attack_damage = PlayerVars.attack_damage + mask_data.attack_damage_bonus
				hurtbox.damage(attack)
	
	# Attack again if the player is still holding the mouse down.
	if Input.is_action_pressed("ui_left_mouse_button"):
		rig_animator.play("attack")
