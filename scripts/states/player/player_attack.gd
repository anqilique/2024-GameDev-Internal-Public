extends State
class_name PlayerAttack

@export var attack_cooldown : float

var player

"""
AttackTimer will be a placeholder until proper animations are established!
Replace the timeout with an animation finished signal.
"""

func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.get_node("AttackTimer").start()
	
	# Attack all enemies within the player's attack range.
	for body in player.get_node("Rig/Hitbox3D").get_overlapping_bodies():
		if body.has_node("HurtboxComponent") and body.is_in_group("Enemies"):
			var hurtbox = body.get_node("HurtboxComponent")
			var attack = Attack.new()
			
			attack.attack_damage = PlayerVars.attack_damage
			hurtbox.damage(attack)

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
		
	player.velocity.x = move_toward(player.velocity.x, 0, PlayerVars.speed)
	player.velocity.z = move_toward(player.velocity.z, 0, PlayerVars.speed)
	
	player.move_and_slide()
