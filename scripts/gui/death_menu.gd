extends Control

var pause_menu

func _ready():
	pause_menu = get_parent().get_node("PauseMenu")
	hide()

func show_screen():
	if len(PlayerVars.broken_masks) < 5:
		$RespawnButton.text = "RESPAWN"
	else:
		$RespawnButton.text = "RESTART"
	
	$ScoreLabel.text = "[center]%d" % PlayerVars.score
	$TipBox.text = "[center]~ TIP ~\n\n%s" % Settings.tips.pick_random()
	
	if HandleScore.new_high_set:
		$ScoreText.show()
	else:
		$ScoreText.hide()
	
	pause_menu.hide()
	show()

func hide_screen():
	pause_menu.show()
	hide()

func handle_respawn(with_progress):
	if with_progress:
		var state_machine = get_parent().get_parent().get_node("Player/StateMachine")
		state_machine.on_child_transition(state_machine.current_state, "PlayerIdle")
	else:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
	hide_screen()


func _on_quit_button_pressed():
	AudioHandler.play_sound("Click")
	LoadHandler.load_scene("res://scenes/gui/main_menu.tscn")


func _on_respawn_button_pressed():
	AudioHandler.play_sound("Click")
	handle_respawn(PlayerVars.respawn_with_progress)
