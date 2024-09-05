extends Control

@onready var bar = $TextureProgressBar
@onready var main_scene = get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	update_bar_values(PlayerVars.live_enemies, main_scene.enemies_spawned)

func update_bar_values(current, maximum):
	bar.max_value = maximum
	bar.value = current
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if [PlayerVars.live_enemies, main_scene.enemies_spawned] != [bar.value, bar.max_value]:
		update_bar_values(PlayerVars.live_enemies, main_scene.enemies_spawned)
		$Label.text = "Wave %d | %d Remaining Enemies" % [PlayerVars.wave, PlayerVars.live_enemies]
