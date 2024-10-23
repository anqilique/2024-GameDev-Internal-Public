extends Node

@onready var background_node_one = $AmbienceOne
@onready var background_node_two = $AmbienceTwo


func play_sound(node_name):
	# If sound node exists and sound is enabled.
	if has_node(node_name) and Settings.play_sound_effects:
			get_node(node_name).play()


func _process(_delta: float) -> void:
	
	# If background audio is enabled.
	if Settings.play_background_audio:
		
		# Check both background audio nodes.
		for node in [background_node_one, background_node_two]:
			if not node.is_playing():
				node.play()
	
	# If background audio is disabled.
	elif not Settings.play_background_audio:
		
		# Check both background audio nodes.
		for node in [background_node_one, background_node_two]:
			if node.is_playing():
				node.stop()
