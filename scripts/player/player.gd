extends CharacterBody3D

@onready var camera = $Camera3D
var ray_origin = Vector3()
var ray_end = Vector3()

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func go_to_state(new_state):
	if $StateMachine.current_state.name not in [new_state, "PlayerDeath"]:
		$StateMachine.on_child_transition($StateMachine.current_state, new_state)

func _physics_process(delta):
	handle_look_direction()
	
	if Input.is_action_just_pressed("ui_left_mouse_button"):
		go_to_state("PlayerAttack")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

func handle_look_direction():
	# Get the current physics state.
	var space_state = get_world_3d().direct_space_state
	
	# Get the current mouse position in the viewport.
	var mouse_position = get_viewport().get_mouse_position()
	
	# Set the origin of the ray.
	ray_origin = camera.project_ray_origin(mouse_position)
	
	# Set the end point of the ray.
	ray_end = ray_origin + camera.project_ray_normal(mouse_position) * 5000
	
	# Set the intersection
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var intersection = space_state.intersect_ray(query)
	
	# Set the rig to look at the correct position.
	if not intersection.is_empty():
		var pos = intersection.position
		var look_at_pt = Vector3(pos.x, position.y, pos.z)
		
		$Rig.look_at(look_at_pt, Vector3.UP)


func _on_recovery_timer_timeout():
	if $Rig/player_basic/AnimationPlayer.current_animation == "attack":
		go_to_state("PlayerAttack")
	if $StateMachine.current_state.name == "PlayerTakeDMG": go_to_state("PlayerIdle")
