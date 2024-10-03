extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
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
	get_tree().change_scene_to_file("res://scenes/main.tscn")


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
