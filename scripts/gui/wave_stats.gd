extends Control

@onready var wavebar = $TextureProgressBar
@onready var main_scene = get_parent().get_parent()
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	wavebar.value = PlayerVars.live_enemies
	wavebar.max_value = main_scene.enemies_spawned

func update_bar(bar, current, maximum):
	if not tween or not tween.is_running():
		tween = get_tree().create_tween()
		tween.tween_property(bar, "value", current, 0.15).set_trans(Tween.TRANS_LINEAR)
		tween.tween_property(bar, "max_value", maximum, 0.15).set_trans(Tween.TRANS_LINEAR)
		
		tween.bind_node(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if [PlayerVars.live_enemies, main_scene.enemies_spawned] != [wavebar.value, wavebar.max_value]:
		update_bar(wavebar, PlayerVars.live_enemies, main_scene.enemies_spawned)
		
		$Label.text = "Wave %d | %d Remaining Enemies" % [PlayerVars.wave, PlayerVars.live_enemies]
