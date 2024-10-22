extends Node

const FULLSCREEN_MODE = 3
const WINDOWED_MODE = 0

@onready var music_enabled_icon = preload("res://assets/musicOn.png")
@onready var music_disabled_icon = preload("res://assets/musicOff.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	Settings.current_window_mode = DisplayServer.window_get_mode()
	
	# Set the check buttons to saved values.
	$Panels/SettingsPanel/SFX.button_pressed = Settings.play_sound_effects
	$Panels/SettingsPanel/BGM.button_pressed = Settings.play_background_audio
	
	# Check if in fullscreen or not, set the check button.
	if Settings.current_window_mode != FULLSCREEN_MODE:
		$Panels/SettingsPanel/FullScreen.button_pressed = false
	else:
		$Panels/SettingsPanel/FullScreen.button_pressed = true
	
	hide_panels()


func hide_panels():
	for panel in $Panels.get_children():
		panel.hide()


"""
Menu Buttons
"""

func _on_play_button_pressed() -> void:
	LoadHandler.load_scene("res://scenes/main.tscn")


func on_panel_button_pressed(panel_node):
	if panel_node.is_visible():
		panel_node.hide()  # Hide panel.
	else:
		hide_panels()  # Hide all other panels.
		panel_node.show()  # Show selected panel.


func _on_controls_button_pressed() -> void:
	on_panel_button_pressed($Panels/ControlsPanel)


func _on_settings_button_pressed() -> void:
	on_panel_button_pressed($Panels/SettingsPanel)


func _on_credits_button_pressed() -> void:
	on_panel_button_pressed($Panels/ControlsPanel)


func _on_button_down() -> void:
	AudioHandler.play_sound("Click")


func _on_full_screen_pressed() -> void:
	# Go to load screen for less jarring transition.
	LoadHandler.load_scene("res://scenes/gui/main_menu.tscn")
	await get_tree().create_timer(0.5).timeout
	
	# Switch to other window mode.
	if Settings.current_window_mode == FULLSCREEN_MODE:
		DisplayServer.window_set_mode(WINDOWED_MODE)
	else:
		DisplayServer.window_set_mode(FULLSCREEN_MODE)
	
	# Remember new window mode.
	Settings.current_window_mode = DisplayServer.window_get_mode()


func _on_sfx_pressed() -> void:
	if Settings.play_sound_effects:
		Settings.play_sound_effects = false
		$Panels/SettingsPanel/SFX/Sprite2D.texture = music_disabled_icon
	else:
		Settings.play_sound_effects = true
		$Panels/SettingsPanel/SFX/Sprite2D.texture = music_enabled_icon
		
	$Panels/SettingsPanel/SFX.button_pressed = Settings.play_sound_effects


func _on_bgm_pressed() -> void:
	if Settings.play_background_audio:
		Settings.play_background_audio = false
		$Panels/SettingsPanel/BGM/Sprite2D.texture = music_disabled_icon
	else:
		Settings.play_background_audio = true
		$Panels/SettingsPanel/BGM/Sprite2D.texture = music_enabled_icon
	
	$Panels/SettingsPanel/BGM.button_pressed = Settings.play_background_audio
