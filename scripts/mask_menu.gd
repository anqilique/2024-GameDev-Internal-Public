extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide_menu()

func show_menu(location):
	position = location
	show()

func hide_menu():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_right_mouse_button"):
		var get_mouse_pos = get_global_mouse_position()
		show_menu(get_mouse_pos)
	
	elif Input.is_action_just_released("ui_right_mouse_button"):
		hide_menu()
