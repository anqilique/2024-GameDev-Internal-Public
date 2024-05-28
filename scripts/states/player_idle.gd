extends State
class_name PlayerIdle

var player

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func enter():
	print("Player is idling!")

func update(delta):
	if (
		Input.is_action_just_pressed("ui_left") or 
		Input.is_action_just_pressed("ui_right") or
		Input.is_action_just_pressed("ui_up") or
		Input.is_action_just_pressed("ui_down")
	):
		get_parent().on_child_transition(self, "PlayerMove")
