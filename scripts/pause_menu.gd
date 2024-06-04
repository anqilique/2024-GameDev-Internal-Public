extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$WhenPaused.hide()
	$WhenPaused/ColorRect.z_index = -1

func switch_to_pause(pause_game):
	if pause_game:
		$WhenPaused.show()
		get_tree().paused = true
	else:
		$WhenPaused.hide()
		get_tree().paused = false

func _on_pause_button_pressed():
	if $WhenPaused.is_visible():
		switch_to_pause(false)
	else:
		switch_to_pause(true)

func _on_resume_button_pressed():
	switch_to_pause(false)

func _on_options_button_pressed():
	print("Bring up options menu!")

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
