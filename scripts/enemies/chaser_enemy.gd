extends CharacterBody3D

@export var statetimer_min : float
@export var statetimer_max : float
@onready var time_in_state : float

@onready var state_machine = $StateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health_range = [80, 120]


func _ready():
	reset_statetimer()
	$Rig/CPUParticles3D.emitting = true
	
	$HealthBar.hide()
	
	$HealthComponent.max_health = randi_range(health_range[0], health_range[1])
	$HealthComponent.health = $HealthComponent.max_health
	$HealthBar.set_values()


func reset_statetimer():
	# Randomize the time the enemy spends wandering/idling.
	time_in_state = randf_range(statetimer_min, statetimer_max)
	$StateTimer.wait_time = time_in_state
	$StateTimer.start()


func go_to_state(new_state):
	state_machine.on_child_transition(state_machine.current_state, new_state)


func check_can_chase(_player):
	if (
		# If the enemy is not already chasing the player or being hit...
		state_machine.current_state.name not in ["EnemyChase", "EnemyTakeDMG"]
		
		# And the enemy is not already mid-attack.
		and state_machine.current_state.name != "EnemyAttack"
		
		# And if enemy is not recovering from a hit.
		and $RecoveryTimer.is_stopped()
	):
		# Check if there is anything colliding with the raycast.
		if $VisionRayCast3D.is_colliding():
			var colliding_with = $VisionRayCast3D.get_collider()
			
			# Only chase if there are no objects between enemy and player.
			if colliding_with.name == "Player":
				go_to_state("EnemyChase")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
	
	# Check everything overlapping with raycast.
	for body in $Vision3D.get_overlapping_bodies():
		if body.name == "Player":  # If player detected, check if can chase.
			check_can_chase(body)
			
			# Always keep the raycast pointing towards the player.
			var look_at_target_pos = Vector3(body.position.x, self.position.y, body.position.z)
			
			$VisionRayCast3D.look_at(look_at_target_pos, Vector3.UP)
			$VisionRayCast3D.force_raycast_update()


func switch_state(current_state):
	match current_state:  # Switch between idle or wander.
		"EnemyIdle" :  
			go_to_state("EnemyWander")
		"EnemyWander" :
			go_to_state("EnemyIdle")
	
	# Randomize the time spent in that state.
	reset_statetimer()


func _on_state_timer_timeout():  # Switch states.
	switch_state(state_machine.current_state.name)


func _on_vision_3d_body_entered(body):
	if body.name == "Player":  # When player enters range, try chase.
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			check_can_chase(body)


func _on_vision_3d_body_exited(body):  # If player goes out of range, back to idle.
	if body.name == "Player" and state_machine.current_state.name != "EnemyIdle":
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			go_to_state("EnemyIdle")


func _on_navigation_agent_3d_target_reached():  # If reached player location.
	go_to_state("EnemyAttack")


func _on_hitbox_3d_body_entered(body):
	if body.name == "Player":  # If player in range and alive.
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			go_to_state("EnemyAttack")


func _on_hitbox_3d_body_exited(body):
		if body.name == "Player":  # If player leaves the enemy's detect range.
			go_to_state("EnemyIdle")
			check_can_chase(body)
