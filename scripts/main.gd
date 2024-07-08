extends Node3D

@export var passive_enemy_scene : PackedScene
@export var chaser_enemy_scene : PackedScene

const ENEMY_SPAWN_Y = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVars.current_health = PlayerVars.starting_health
	spawn_enemies(2, 2)

func spawn_enemies(how_many_passive, how_many_chaser):
	for n in range(how_many_passive):  # Spawn passive enemies.
		var new_enemy = passive_enemy_scene.instantiate()
		
		# Randomize position.
		var rand_x = randf_range(-22, 22)
		var rand_z = randf_range(-16, 22)
		new_enemy.position = Vector3(rand_x, ENEMY_SPAWN_Y, rand_z)
		
		new_enemy.add_to_group("Enemies")
		add_child(new_enemy)
	
	for n in range(how_many_chaser):  # Spawn chaser enemies.
		var new_enemy = chaser_enemy_scene.instantiate()
		
		# Randomize position.
		var rand_x = randf_range(-22, 22)
		var rand_z = randf_range(-16, 22)
		new_enemy.position = Vector3(rand_x, ENEMY_SPAWN_Y, rand_z)
		
		new_enemy.add_to_group("Enemies")
		add_child(new_enemy)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
