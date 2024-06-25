extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

"""
Menu Buttons
"""

func _on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gui/full_menus/start_menu.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gui/full_menus/controls_menu.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gui/full_menus/settings_menu.tscn")

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gui/full_menus/credits_menu.tscn")
