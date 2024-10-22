extends State
class_name PlayerDeath

var player


func calculate_score():
	PlayerVars.score = PlayerVars.lifetime
	PlayerVars.score *= PlayerVars.level
	
	if len(PlayerVars.broken_masks) != 5:
		PlayerVars.score += PlayerVars.score * (5 - len(PlayerVars.broken_masks))
	
	HandleScore.save_high_score(PlayerVars.score)


func enter():
	AudioHandler.play_sound("PlayerDeath")
	
	player = get_tree().get_first_node_in_group("Player")
	player.change_visibility("hide")
	player.get_node("LifeTimer").stop()
	
	# If current mask is not already stored in broken masks.
	if PlayerVars.current_mask not in PlayerVars.broken_masks:
		PlayerVars.broken_masks.append(PlayerVars.current_mask)
	
	calculate_score()
	
	var main_scene = player.get_parent()
	main_scene.get_node("LayerUI/DeathMenu").show_screen()


func exit():
	player.change_visibility("show")
	
	PlayerVars.respawn_with_progress = false
	
	# Attempt to switch to next available mask.
	for mask in PlayerVars.masks:
		if mask not in PlayerVars.broken_masks:
			PlayerVars.current_mask = mask
			PlayerVars.respawn_with_progress = true

	# If can not find an available mask, respawn without progress.
	if not PlayerVars.respawn_with_progress:
		PlayerVars.reset_to_defaults()
	
	# Reset the player's health.
	PlayerVars.current_health = PlayerVars.max_health
	
	# Update the health component.
	var health_comp = player.get_node("HealthComponent")
	health_comp.health = PlayerVars.current_health
	health_comp.max_health = PlayerVars.max_health
	
	player.global_position = PlayerVars.starting_point
