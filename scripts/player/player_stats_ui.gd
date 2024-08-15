extends Control

@onready var bar = $Health/TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	bar.value = PlayerVars.current_health
	bar.max_value = PlayerVars.max_health

func update_health(current, maximum):
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", current, 0.25).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(bar, "max_value", maximum, 0.25).set_trans(Tween.TRANS_LINEAR)
	
	tween.bind_node(self)

func update_mask(current):
	$Mask/Label.text = "M" + str(current)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	 # If the local node values don't match the global ones...
	if (
		PlayerVars.current_health != bar.value
		or PlayerVars.max_health != bar.max_value
	):
		update_health(PlayerVars.current_health, PlayerVars.max_health)
	
	if str(PlayerVars.current_mask) not in $Mask/Label.text:
		update_mask(PlayerVars.current_mask)
