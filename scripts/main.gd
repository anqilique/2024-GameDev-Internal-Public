extends Node3D

@export var passive_enemy_scene : PackedScene
@export var chaser_enemy_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies(10, 5)

func spawn_enemies(how_many_passive, how_many_chaser):
	for n in range(how_many_passive):  # Spawn passive enemies.
		var new_enemy = passive_enemy_scene.instantiate()
		
		# Randomize position.
		var rand_x = randf_range(-10, 10)
		var rand_z = randf_range(-10, 10)
		new_enemy.position = Vector3(rand_x, 0.5, rand_z)
		
		new_enemy.add_to_group("Enemies")
		add_child(new_enemy)
	
	for n in range(how_many_chaser):  # Spawn chaser enemies.
		var new_enemy = chaser_enemy_scene.instantiate()
		
		# Randomize position.
		var rand_x = randf_range(-20, 20)
		var rand_z = randf_range(-20, 20)
		new_enemy.position = Vector3(rand_x, 0.5, rand_z)
		
		new_enemy.add_to_group("Enemies")
		add_child(new_enemy)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
