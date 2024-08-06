extends State
class_name PlayerDeath

var player

func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.change_visibility("hide")
	
	if PlayerVars.current_mask not in PlayerVars.broken_masks:
		PlayerVars.broken_masks.append(PlayerVars.current_mask)
	
	var main_scene = player.get_parent()
	main_scene.get_node("LayerUI/DeathMenu").show_screen()

func exit():
	print("--> Exiting death state.")
	player.change_visibility("show")
	
	# If all masks are broken --> Respawn without progress.
	if PlayerVars.broken_masks.size() == 5:
		pass
		
	else:  # Else --> Switch to next available mask.
		if PlayerVars.current_mask in PlayerVars.broken_masks:
			for mask in PlayerVars.masks.keys():
				if mask not in PlayerVars.broken_masks:
					PlayerVars.current_mask = mask
	
	PlayerVars.current_health = PlayerVars.max_health
	
	var health_comp = player.get_node("HealthComponent")
	health_comp.health = PlayerVars.current_health
	health_comp.max_health = PlayerVars.max_health
	
	print(get_parent().current_state)
	
	player.global_position = Vector3(0, 4.8, 0)
