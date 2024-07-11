extends Control

func _ready():
	hide()

func show_screen():
	
	var pause_menu = get_parent().get_node("PauseMenu")
	pause_menu.hide()
	
	show()


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gui/full_menus/start_menu.tscn")


func _on_respawn_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
