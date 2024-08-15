extends State
class_name PlayerDeath

var player

func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.change_visibility("hide")
	
	print(PlayerVars.current_mask, PlayerVars.broken_masks)
	
	if PlayerVars.current_mask not in PlayerVars.broken_masks:
		PlayerVars.broken_masks.append(PlayerVars.current_mask)
	
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
		for mask in PlayerVars.masks.keys():
			if mask not in PlayerVars.broken_masks:
				PlayerVars.current_mask = mask
	
	# If can not find an available mask, respawn without progress.
	if PlayerVars.current_mask in PlayerVars.broken_masks:
		PlayerVars.wave = 0
		PlayerVars.broken_masks = []
		PlayerVars.current_mask = 5
		
		player.get_parent().reset_scene()
		
		print("<-- RELOADED -->")
		print(PlayerVars.broken_masks)
	
	PlayerVars.current_health = PlayerVars.max_health
	
	var health_comp = player.get_node("HealthComponent")
	health_comp.health = PlayerVars.current_health
	health_comp.max_health = PlayerVars.max_health
	
	print(get_parent().current_state)
	
	player.global_position = Vector3(0, 4.8, 0)
