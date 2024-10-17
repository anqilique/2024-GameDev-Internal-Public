extends Control

var mask_colours_dict = {
	1 : Settings.blue,
	2 : Settings.red,
	3 : Settings.white,
	4 : Settings.green,
	5 : Settings.yellow,
}


func update_player_stats_panel():
	var label = $PlayerStatsPanel/RichTextLabel
	var mask_text_colours = []
	
	# Determine the colours of the mask strings.
	for mask in PlayerVars.masks:
		if mask in PlayerVars.broken_masks:
			mask_text_colours.append("FFFFFF78")
		else:
			mask_text_colours.append(mask_colours_dict[mask])
	
	var new_text = (  # Format the entire label.
		"[center] %d Essence\n\n" % PlayerVars.essence
		+ "Level %d\n" % PlayerVars.level
		+ "Wave %d\n\n" % PlayerVars.wave
		+ "%d Base Health\n" % PlayerVars.base_max_health
		+ "%d Base Speed\n" % PlayerVars.base_speed
		+ "%d Base Damage\n\n" % PlayerVars.attack_damage
		+ "[color=%s]Mask of Swiftness[/color]\n" % mask_text_colours[0]
		+ "[color=%s]Mask of Flight[/color]\n" % mask_text_colours[1]
		+ "[color=%s]Mask of Fury[/color]\n" % mask_text_colours[2]
		+ "[color=%s]Mask of Healing[/color]\n" % mask_text_colours[3]
		+ "[color=%s]Mask of Balance[/color]\n\n" % mask_text_colours[4]
		+ "%d Broken Masks" % len(PlayerVars.broken_masks)
	)
	
	label.text = new_text
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_stats_panel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_return_button_pressed() -> void:
	get_tree().paused = false
	hide()
