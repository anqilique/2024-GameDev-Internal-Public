extends Control

@onready var bar = $TextureProgressBar
@onready var main_scene = get_parent().get_parent()
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	bar.value = PlayerVars.live_enemies
	bar.max_value = main_scene.enemies_spawned

func update_bar(bar, current, maximum):
	if not tween or not tween.is_running():
		tween = get_tree().create_tween()
		tween.tween_property(bar, "value", current, 0.15).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(bar, "max_value", maximum, 0.15).set_trans(Tween.TRANS_LINEAR)
		
		tween.bind_node(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if [PlayerVars.live_enemies, main_scene.enemies_spawned] != [bar.value, bar.max_value]:
		update_bar(bar, PlayerVars.live_enemies, main_scene.enemies_spawned)
		
		$Label.text = "Wave %d | %d Remaining Enemies" % [PlayerVars.wave, PlayerVars.live_enemies]
