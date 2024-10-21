extends Control

var pause_menu
var final_death_text = """
[p][center]You Have Died
[p][center]For The Final Time
"""


func _ready():
	
	$RespawnButton.show()
	$RespawnButton.disabled = false
	$DeathText.text = "[center]\nYou Have Died"
	
	pause_menu = get_parent().get_node("PauseMenu")
	hide()


func show_screen():
	var mask_name_text = ""
	
	# If player has not broken all five masks.
	if len(PlayerVars.broken_masks) < 5:
		$RespawnButton.text = "RESPAWN"  # No need to restart, just respawn.
		
		match PlayerVars.current_mask:
			1 : mask_name_text = "[color=%s]Mask of Swiftness" % Settings.blue
			2 : mask_name_text = "[color=%s]Mask of Flight" % Settings.red
			3 : mask_name_text = "[color=%s]Mask of Fury" % Settings.white
			4 : mask_name_text = "[color=%s]Mask of Healing" % Settings.green
			5 : mask_name_text = "[color=%s]Mask of Balance" % Settings.yellow
		
		# Display to player which mask has broken on death.
		$MaskText.text = "[center]The %s[/color] Has Broken..." % mask_name_text
		
	else: # All masks have been broken, so no option to respawn.
		
		$RespawnButton.text = "RESTART"
		$MaskText.text = "[center]All Masks Have Been Broken..."
		
		$DeathText.text = final_death_text
		
		$RespawnButton.hide()
		$RespawnButton.disabled = true
	
	# Display score and random tip.
	$HighScore.text = "[center]%d" % PlayerVars.score
	$TipBox.text = "[center]~ TIP ~\n\n%s" % Settings.tips.pick_random()
	
	if HandleScore.new_high_set:
		$ScoreText.text = "[center]New High Score!"
		$ScoreText.show()
		
	else:
		var fetched_score = HandleScore.load_high_score()
		$ScoreText.text = "[center]Last High Score of %d!" % fetched_score
	
	$ScoreText.show()
	pause_menu.hide()
	show()


func hide_screen():
	pause_menu.show()
	hide()


func handle_respawn():  # Send player to idle, hide death screen.
	var state_machine = get_parent().get_parent().get_node("Player/StateMachine")
	state_machine.on_child_transition(state_machine.current_state, "PlayerIdle")
	hide_screen()


func _on_quit_button_pressed():
	AudioHandler.play_sound("Click")
	
	PlayerVars.reset_to_defaults()
	LoadHandler.load_scene("res://scenes/gui/main_menu.tscn")


func _on_respawn_button_pressed():
	AudioHandler.play_sound("Click")
	handle_respawn()
