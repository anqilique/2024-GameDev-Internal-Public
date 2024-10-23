extends Node3D

@onready var bar = $SubViewport/CanvasLayer/TextureProgressBar
var tween


func update_health(current, maximum):
	if not tween or not tween.is_running():
		tween = get_tree().create_tween()
		tween.tween_property(bar, "value", current, 0.25).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(bar, "max_value", maximum, 0.25).set_trans(Tween.TRANS_LINEAR)
		
		tween.bind_node(self)


func get_component_health(type):
	var health_value
	
	match type:
		"current": 
			health_value = get_parent().get_node("HealthComponent").health
		"max":
			health_value = get_parent().get_node("HealthComponent").max_health
	
	return health_value


func set_values():
	bar.value = get_component_health("current")
	bar.max_value = get_component_health("max")


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
	bar.value = get_component_health("current")
	bar.max_value = get_component_health("max")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (
		get_component_health("current") != bar.value
		or get_component_health("max") != bar.max_value
	):
		update_health(get_component_health("current"), get_component_health("max"))
	
	if bar.value == bar.max_value:
		hide()
	elif not is_visible() and $SetUpTimer.is_stopped():
		#show()  # Disabled due to janky visuals.
		pass
