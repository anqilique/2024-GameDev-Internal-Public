extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$WhenPaused.hide()
	$PauseButton.z_index = 1
	
	for node in get_node("WhenPaused").get_children():
		if node.name == "ColorRect":
			node.z_index = 0
		else:
			node.z_index = 1

func handle_ui_visibility(hide_list, show_list):
	if hide_list != []:
		for named in hide_list:
			var node  = get_parent().get_node(named)
			if node.is_visible():
				node.hide()
	
	if show_list != []:
		for named in show_list:
			var node  = get_parent().get_node(named)
			if not node.is_visible():
				node.show()

func switch_to_pause(pause_game):
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

func _on_options_button_pressed():
	print("Bring up options menu!")

func _on_exit_pressed():
	switch_to_pause(false)
	get_tree().change_scene_to_file("res://scenes/gui/full_menus/start_menu.tscn")
