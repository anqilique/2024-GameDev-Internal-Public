extends Control

const SHORTCUT = "ui_right_mouse_button"

var change_mask_to

# Called when the node enters the scene tree for the first time.
func _ready():
	change_mask_to = PlayerVars.current_mask
	hide_menu()

func show_menu(location):
	position = location
	Engine.time_scale = 0.2
	show()

func hide_menu():
	Engine.time_scale = 1
	hide()
	
	if PlayerVars.current_mask != change_mask_to:
		PlayerVars.current_mask = change_mask_to
	
func mask_selected(button):
	change_mask_to = button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (
		Input.is_action_just_pressed(SHORTCUT)
		and PlayerVars.current_health > 0
		):
		var get_mouse_pos = get_global_mouse_position()
		show_menu(get_mouse_pos)
	
	elif (
		Input.is_action_just_released(SHORTCUT)
		or is_visible() and not Input.is_action_pressed(SHORTCUT)
		):
		
		hide_menu()

"""
Mask Button Signals
"""

func _on_1_mouse_entered():
	mask_selected(1)

func _on_2_mouse_entered():
	mask_selected(2)

func _on_3_mouse_entered():
	mask_selected(3)

func _on_4_mouse_entered():
	mask_selected(4)

func _on_5_mouse_entered():
	mask_selected(5)
