extends Control
var pause_menu

func _ready():
	pause_menu = get_parent().get_node("PauseMenu")
	hide()

func show_screen():
	pause_menu.hide()
	show()

func hide_screen():
	pause_menu.show()
	hide()


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gui/full_menus/start_menu.tscn")


func _on_respawn_button_pressed():
	var state_machine = get_parent().get_parent().get_node("Player/StateMachine")
	state_machine.on_child_transition(state_machine.current_state, "PlayerIdle")
	hide_screen()
