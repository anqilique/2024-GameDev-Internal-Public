extends State
class_name PlayerIdle

const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var player

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func update(delta):
	if (
		Input.is_action_just_pressed("ui_left") or 
		Input.is_action_just_pressed("ui_right") or
		Input.is_action_just_pressed("ui_up") or
		Input.is_action_just_pressed("ui_down") or
		Input.is_action_just_pressed("ui_accept")
	):
		get_parent().on_child_transition(self, "PlayerMove")

func physics_update(delta):
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY
	
	player.move_and_slide()
