extends State
class_name PlayerDeath

var player

func enter():
	player = get_tree().get_first_node_in_group("Player")
	player.set_collision_layer(4)  # Empty Layer
	player.get_node("Rig").hide()
