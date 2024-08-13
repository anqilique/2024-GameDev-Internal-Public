extends Control

@onready var bar = $TextureProgressBar
@onready var main_scene = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	bar.max_value = main_scene.enemies_spawned

func update_bar_values(value, max_value):
	bar.max_value = max_value
	bar.value = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bar.max_value != main_scene.enemies_spawned or bar.value != PlayerVars.live_enemies:
		update_bar_values(PlayerVars.live_enemies, main_scene.enemies_spawned)
