extends Node3D

@export var passive_enemy_scene : PackedScene
@export var chaser_enemy_scene : PackedScene

const ENEMY_SPAWN_Y = 3

var tutorial_waves = PlayerVars.starting_waves
var spawn_count = [1, 0]
var enemies_spawned = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVars.broken_masks = []
	PlayerVars.current_mask = 5
	PlayerVars.current_health = PlayerVars.starting_health
	
	spawn_enemies(false, spawn_count[0], spawn_count[1])

func update_spawn_count():
	print(spawn_count, tutorial_waves)
	
	if tutorial_waves != []:
		if spawn_count in tutorial_waves:
			tutorial_waves.erase(spawn_count)
			
			if tutorial_waves != []:
				spawn_count = tutorial_waves[0]
		else:
			spawn_count[0] += 1
			spawn_count[1] += 1

func reset_scene():
	tutorial_waves = PlayerVars.starting_waves
	update_spawn_count()
	spawn_enemies(true, spawn_count[0], spawn_count[1])

func spawn_enemies(free_old, how_many_passive, how_many_chaser):
	enemies_spawned = 0
	
	print(get_tree().get_nodes_in_group("Enemies"))
	
	if free_old:
		for old_enemy in get_tree().get_nodes_in_group("Enemies"):
			old_enemy.queue_free()
	
	for n in range(how_many_passive):  # Spawn passive enemies.
		var new_enemy = passive_enemy_scene.instantiate()
		
		# Randomize position.
		var rand_x = randf_range(-22, 22)
		var rand_z = randf_range(-16, 22)
		new_enemy.position = Vector3(rand_x, ENEMY_SPAWN_Y, rand_z)
		
		new_enemy.add_to_group("Enemies")
		add_child(new_enemy)
		
		enemies_spawned += 1
	
	for n in range(how_many_chaser):  # Spawn chaser enemies.
		var new_enemy = chaser_enemy_scene.instantiate()
		
		# Randomize position.
		var rand_x = randf_range(-22, 22)
		var rand_z = randf_range(-16, 22)
		new_enemy.position = Vector3(rand_x, ENEMY_SPAWN_Y, rand_z)
		
		new_enemy.add_to_group("Enemies")
		add_child(new_enemy)
		
		enemies_spawned += 1
	
	PlayerVars.live_enemies = enemies_spawned
	PlayerVars.wave += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if PlayerVars.live_enemies == 0 and get_tree().get_nodes_in_group("Enemies") == []:
		update_spawn_count()
		spawn_enemies(false, spawn_count[0], spawn_count[1])
