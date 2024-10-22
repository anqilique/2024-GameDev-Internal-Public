extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$WhenPaused.hide()
	$PauseButton.z_index = 1
	
	# Show the coloured rectangle below others.
	for node in get_node("WhenPaused").get_children():
		if node.name == "ColorRect":
			node.z_index = 0
		else:
			node.z_index = 1


func handle_ui_visibility(hide_list, show_list):
	if hide_list != []:
		for named in hide_list:  # Hide all nodes listed.
			var node  = get_parent().get_node(named)
			if node.is_visible():
				node.hide()
	
	if show_list != []:
		for named in show_list:  # Show all nodes listed.
			var node  = get_parent().get_node(named)
			if not node.is_visible():
				node.show()


func switch_to_pause(pause_game):
	AudioHandler.play_sound("Click")
	
	if pause_game:
		$WhenPaused.show()
		get_tree().paused = true
		handle_ui_visibility(["MaskMenu"], [])
		
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


func _on_exit_pressed():
	switch_to_pause(false)
	PlayerVars.reset_to_defaults()
	LoadHandler.load_scene("res://scenes/gui/main_menu.tscn")
	
	handle_ui_visibility(["MaskMenu", "UpgradesMenu"], [])


func _on_button_down() -> void:
	AudioHandler.play_sound("Click")
