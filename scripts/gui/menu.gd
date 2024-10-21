extends Node

const FULLSCREEN_MODE = 3
const WINDOWED_MODE = 0

@onready var music_enabled_icon = preload("res://assets/musicOn.png")
@onready var music_disabled_icon = preload("res://assets/musicOff.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	Settings.current_window_mode = DisplayServer.window_get_mode()
	
	$Panels/SettingsPanel/SFX.button_pressed = Settings.play_sound_effects
	$Panels/SettingsPanel/BGM.button_pressed = Settings.play_background_audio

	if Settings.current_window_mode != FULLSCREEN_MODE:
		$Panels/SettingsPanel/FullScreen.button_pressed = false
	else:
		$Panels/SettingsPanel/FullScreen.button_pressed = true
	
	
	hide_panels()


func hide_panels():
	for panel in $Panels.get_children(): panel.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

"""
Menu Buttons
"""

func _on_play_button_pressed() -> void:
	LoadHandler.load_scene("res://scenes/main.tscn")


func _on_controls_button_pressed() -> void:
	if $Panels/ControlsPanel.is_visible(): $Panels/ControlsPanel.hide()
	else:
		hide_panels()
		$Panels/ControlsPanel.show()


func _on_settings_button_pressed() -> void:
	if $Panels/SettingsPanel.is_visible(): $Panels/SettingsPanel.hide()
	else:
		hide_panels()
		$Panels/SettingsPanel.show()


func _on_credits_button_pressed() -> void:
	if $Panels/CreditsPanel.is_visible(): $Panels/CreditsPanel.hide()
	else:
		hide_panels()
		$Panels/CreditsPanel.show()


func _on_button_down() -> void:
	AudioHandler.play_sound("Click")


func _on_full_screen_pressed() -> void:
	LoadHandler.load_scene("res://scenes/gui/main_menu.tscn")
	await get_tree().create_timer(0.5).timeout
	
	if Settings.current_window_mode == FULLSCREEN_MODE:
		DisplayServer.window_set_mode(WINDOWED_MODE)
	else:
		DisplayServer.window_set_mode(FULLSCREEN_MODE)
	
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
