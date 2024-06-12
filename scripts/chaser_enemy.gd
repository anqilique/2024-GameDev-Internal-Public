extends CharacterBody3D

@export var statetimer_min : float
@export var statetimer_max : float

@onready var time_in_state : float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	reset_statetimer()

func reset_statetimer():
	time_in_state = randf_range(statetimer_min, statetimer_max)
	$StateTimer.wait_time = time_in_state
	$StateTimer.start()

func check_can_chase(player):
	if $StateMachine.current_state.name != "EnemyChase":
		var player_pos = player.global_transform.origin
		
		$VisionRayCast3D.look_at(player_pos, Vector3.UP)
		$VisionRayCast3D.force_raycast_update()
		
		if $VisionRayCast3D.is_colliding():
			var colliding_with = $VisionRayCast3D.get_collider()
			
			if colliding_with.name == "Player":
				pass
				#$StateMachine.on_child_transition($StateMachine.current_state, "EnemyChase")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()
	
	for body in $Vision3D.get_overlapping_bodies():
		if body.name == "Player":
			check_can_chase(body)


func go_to_new_state(current_state):
	if current_state == "EnemyIdle":
		$StateMachine.on_child_transition($StateMachine.current_state, "EnemyWander")
	elif current_state == "EnemyWander":
		$StateMachine.on_child_transition($StateMachine.current_state, "EnemyIdle")
	
	reset_statetimer()

func _on_state_timer_timeout():
	go_to_new_state($StateMachine.current_state.name)


func _on_vision_3d_body_entered(body):
	if body.name == "Player":
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			check_can_chase(body)


func _on_vision_3d_body_exited(body):
	if body.name == "Player": # and $StateMachine.current_state.name != "EnemyIdle"
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			print("Switching to Chase State! I DON'T see you!")
			$StateMachine.on_child_transition($StateMachine.current_state, "EnemyIdle")
