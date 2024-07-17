extends CharacterBody3D

const HEALTH_BONUS = 15
const ESSENCE_BONUS = 5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	velocity.y = randf_range(0, 1)
	velocity.x = randf_range(-2, 2)
	velocity.z = randf_range(-2, 2)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()

func collect_health():
	PlayerVars.current_health += HEALTH_BONUS
	if PlayerVars.current_health > PlayerVars.max_health:
		PlayerVars.current_health = PlayerVars.max_health


func collect_essence():
	PlayerVars.essence += ESSENCE_BONUS


func _on_collect_area_3d_body_entered(body):
	if body.name == "Player":  # Collectable only by the player.
		
		# Get the right type of collectable effects.
		if is_in_group("Health Collectables"): collect_health()
		elif is_in_group("Essence Collectables"): collect_essence()
		
		queue_free()
