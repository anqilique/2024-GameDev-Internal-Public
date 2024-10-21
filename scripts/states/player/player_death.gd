extends State
class_name PlayerDeath

var player

func calculate_score():
	PlayerVars.score = PlayerVars.lifetime
	PlayerVars.score *= PlayerVars.level
	
	if len(PlayerVars.broken_masks) != 5:
		PlayerVars.score *= (5 - len(PlayerVars.broken_masks))
	
	HandleScore.save_high_score(PlayerVars.score)


func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.change_visibility("hide")
	
	print(PlayerVars.current_mask, PlayerVars.broken_masks)
	
	if PlayerVars.current_mask not in PlayerVars.broken_masks:
		PlayerVars.broken_masks.append(PlayerVars.current_mask)
	
	calculate_score()
	
	var main_scene = player.get_parent()
	main_scene.get_node("LayerUI/DeathMenu").show_screen()

func exit():
	print("--> Exiting death state.")
	player.change_visibility("show")
	
	print(PlayerVars.current_mask, " <-- Current")
	print(PlayerVars.broken_masks, " <-- Broken")
	
	# If mask has been broken.
	if PlayerVars.current_mask in PlayerVars.broken_masks:
		# Attempt to switch to next available mask.
		for mask in PlayerVars.masks:
			if mask not in PlayerVars.broken_masks:
				PlayerVars.current_mask = mask
				PlayerVars.respawn_with_progress = true
	
	# If can not find an available mask, respawn without progress.
	if PlayerVars.current_mask in PlayerVars.broken_masks:
		PlayerVars.wave = 0
		PlayerVars.broken_masks = []
		PlayerVars.current_mask = 5
		PlayerVars.respawn_with_progress = false
		
	print("<-- RESPAWNING --> ", PlayerVars.respawn_with_progress)
	
	PlayerVars.current_health = PlayerVars.max_health
	
	var health_comp = player.get_node("HealthComponent")
	health_comp.health = PlayerVars.current_health
	health_comp.max_health = PlayerVars.max_health
	
	player.global_position = Vector3(0, 4.8, 0)
