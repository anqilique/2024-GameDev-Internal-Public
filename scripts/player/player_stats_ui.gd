extends Control

@onready var healthbar = $Health/ProgressBar
@onready var expbar = $EXP/ProgressBar

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	healthbar.value = PlayerVars.current_health
	healthbar.max_value = PlayerVars.max_health
	
	expbar.value = PlayerVars.current_exp
	expbar.max_value = PlayerVars.max_exp

func update_bar(bar, current, maximum):
	if not tween or not tween.is_running():
		tween = get_tree().create_tween()
		tween.tween_property(bar, "value", current, 0.15).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(bar, "max_value", maximum, 0.15).set_trans(Tween.TRANS_LINEAR)
		
		tween.bind_node(self)

func update_mask(current):
	$Mask/Label.text = "M" + str(current)

func update_level(current):
	$EXP/Label.text = "LVL " + str(current)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	 # If the local node values don't match the global ones...
	
	if (
		PlayerVars.current_health != healthbar.value
		or PlayerVars.max_health != healthbar.max_value
	):
		update_bar(healthbar, PlayerVars.current_health, PlayerVars.max_health)
	
	if (
		PlayerVars.current_exp != expbar.value
		or PlayerVars.max_exp != expbar.max_value
	):
		update_bar(expbar, PlayerVars.current_exp, PlayerVars.max_exp)
	
	
	# Update labels
	
	if str(PlayerVars.current_mask) not in $Mask/Label.text:
		update_mask(PlayerVars.current_mask)
	
	if str(PlayerVars.level) not in $EXP/Label.text:
		update_level(PlayerVars.level)
	
