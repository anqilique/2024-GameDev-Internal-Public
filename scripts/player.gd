extends CharacterBody3D

@onready var camera = $Camera3D
var ray_origin = Vector3()
var ray_end = Vector3()


func _physics_process(delta):
	handle_look_direction()

func handle_look_direction():
	# Get the current physics state.
	var space_state = get_world_3d().direct_space_state
	
	# Get the current mouse position in the viewport.
	var mouse_position = get_viewport().get_mouse_position()
	
	# Set the origin of the ray.
	ray_origin = camera.project_ray_origin(mouse_position)
	
	# Set the end point of the ray.
	ray_end = ray_origin + camera.project_ray_normal(mouse_position) * 2000
	
	# Set the intersection
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var intersection = space_state.intersect_ray(query)
	
	if not intersection.is_empty():
		var pos = intersection.position
		var look_at_y = clamp($Rig.position.y, $Rig.position.y + 0.25, $Rig.position.y + 0.1)
		var look_at_pt = Vector3(pos.x, look_at_y + 0.25, pos.z)
		$Rig.look_at(look_at_pt, Vector3.UP)
