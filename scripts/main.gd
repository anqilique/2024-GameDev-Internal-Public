extends Node3D

@export var passive_enemy_scene : PackedScene
@export var chaser_enemy_scene : PackedScene

const ENEMY_SPAWN_Y = 3

var tutorial_waves = []
var spawn_count = [1, 0]
var enemies_spawned = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVars.broken_masks = []
	PlayerVars.current_mask = 5
	PlayerVars.current_health = PlayerVars.starting_health
	
	for item in PlayerVars.starting_waves:
		tutorial_waves.append(item)
	
	spawn_enemies(spawn_count[0], spawn_count[1])

func update_spawn_count():
	if tutorial_waves != []:
		if spawn_count in tutorial_waves:
			tutorial_waves.erase(spawn_count)
			
			if tutorial_waves != []:
				spawn_count = tutorial_waves[0]
		else:
			spawn_count[0] += 1
			spawn_count[1] += 1

func spawn_enemies(how_many_passive, how_many_chaser):
	enemies_spawned = 0
	
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
	if PlayerVars.live_enemies != get_tree().get_nodes_in_group("Enemies").size():
		PlayerVars.live_enemies = get_tree().get_nodes_in_group("Enemies").size()
	
	var update_spawn = true
	
	if not PlayerVars.respawn_with_progress:
			print(PlayerVars.live_enemies, get_tree().get_nodes_in_group("Enemies"))
			if PlayerVars.live_enemies != 0:
				for old_enemy in get_tree().get_nodes_in_group("Enemies"):
					old_enemy.queue_free()
					print(old_enemy.name)
			
			tutorial_waves = []
			for item in PlayerVars.starting_waves:
				tutorial_waves.append(item)
			print(tutorial_waves)
			
			update_spawn = false
			PlayerVars.respawn_with_progress = true
	
	if PlayerVars.live_enemies == 0:
		if update_spawn: update_spawn_count()
		spawn_enemies(spawn_count[0], spawn_count[1])
