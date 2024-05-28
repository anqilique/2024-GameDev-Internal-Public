extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera = $Camera3D
var ray_origin = Vector3()
var ray_end = Vector3()


func _physics_process(delta):
	#"""
	#Handle the Direction Player Looks
	#"""
	## Get the current physics state.
	#var space_state = get_world_3d().direct_space_state
	#
	## Get the current mouse position in the viewport.
	#var mouse_position = get_viewport().get_mouse_position()
	#
	## Set the origin of the ray.
	#ray_origin = camera.project_ray_origin(mouse_position)
	#
	## Set the end point of the ray.
	#ray_end = ray_origin + camera.project_ray_normal(mouse_position) * 2000
	#
	## Set the intersection
	#var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	#var intersection = space_state.intersect_ray(query)
	#
	#if not intersection.is_empty():
		#var pos = intersection.position
		#$Rig.look_at(Vector3(pos.x, pos.y, pos.z), Vector3(0, 1, 0))
	
	"""
	Handle the Player's Movement
	"""
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
