extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_health(current, max):
	$Health/TextureProgressBar.max_value = max
	$Health/TextureProgressBar.value = current

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (
		PlayerVars.current_health != $Health/TextureProgressBar.value
		or PlayerVars.max_health != $Health/TextureProgressBar.max_value
	):
		update_health(PlayerVars.current_health, PlayerVars.max_health)
