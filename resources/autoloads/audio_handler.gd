extends Node


func play_sound(node_name):
	if has_node(node_name) and Settings.play_sound_effects:
			get_node(node_name).play()


func _process(_delta: float) -> void:
	if Settings.play_background_music and not $BGM.playing:
		$BGM.play()
	elif not Settings.play_background_music:
		$BGM.stop()
