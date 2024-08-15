extends CharacterBody3D

@export var statetimer_min : float
@export var statetimer_max : float

@onready var time_in_state : float

# Get the gravity from the project settings to be synce	d with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	reset_statetimer()

func reset_statetimer():
	# Randomize the time the enemy spends wandering/idling.
	time_in_state = randf_range(statetimer_min, statetimer_max)
	$StateTimer.wait_time = time_in_state
	$StateTimer.start()

func check_can_chase(player):
	# If the enemy is not already chasing the player...
	if (
		$StateMachine.current_state.name != "EnemyChase"
		and $StateMachine.current_state.name != "EnemyAttack"
	):
		# Check if there is anything colliding with the raycast.
		if $VisionRayCast3D.is_colliding():
			var colliding_with = $VisionRayCast3D.get_collider()
			
			# Only chase if there are no objects between enemy and player.
			if colliding_with.name == "Player":
				$StateMachine.on_child_transition($StateMachine.current_state, "EnemyChase")


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

func go_to_new_state(current_state):  # Switch between idle and wander.
	if current_state == "EnemyIdle":
		$StateMachine.on_child_transition($StateMachine.current_state, "EnemyWander")
	elif current_state == "EnemyWander":
		$StateMachine.on_child_transition($StateMachine.current_state, "EnemyIdle")
	
	# Randomize the time spent in that state.
	reset_statetimer()

func _on_state_timer_timeout():  # Switch states.
	go_to_new_state($StateMachine.current_state.name)

func _on_vision_3d_body_entered(body):
	if body.name == "Player":  # When player enters range, try chase.
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			check_can_chase(body)

func _on_vision_3d_body_exited(body):  # If player goes out of range, back to idle.
	if body.name == "Player"and $StateMachine.current_state.name != "EnemyIdle":
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			$StateMachine.on_child_transition($StateMachine.current_state, "EnemyIdle")

func _on_navigation_agent_3d_target_reached():
	$StateMachine.on_child_transition($StateMachine.current_state, "EnemyAttack")

func _on_hitbox_3d_body_entered(body):
	if body.name == "Player":  # If player in range and alive.
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			$StateMachine.on_child_transition($StateMachine.current_state, "EnemyAttack")

func _on_hitbox_3d_body_exited(body):
		if body.name == "Player":  # If player leaves the enemy's detect range.
			$StateMachine.on_child_transition($StateMachine.current_state, "EnemyIdle")
			check_can_chase(body)
