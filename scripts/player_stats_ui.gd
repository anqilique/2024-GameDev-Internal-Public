extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func update_health(current, maximum):
	$Health/TextureProgressBar.max_value = maximum
	$Health/TextureProgressBar.value = current

func update_mask(current):
	$Mask/Label.text = "M" + str(current)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	 # If the local node values don't match the global ones...
	
	if (
		PlayerVars.current_health != $Health/TextureProgressBar.value
		or PlayerVars.max_health != $Health/TextureProgressBar.max_value
	):
		update_health(PlayerVars.current_health, PlayerVars.max_health)
	
	if str(PlayerVars.current_mask) not in $Mask/Label.text:
		update_mask(PlayerVars.current_mask)
