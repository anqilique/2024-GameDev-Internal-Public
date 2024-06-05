extends Node3D

@export var enemy_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_enemies(10)

func spawn_enemies(how_many):
	for n in range(how_many):
		var new_enemy = enemy_scene.instantiate()
		
		var rand_x = randf_range(-20, 20)
		var rand_z = randf_range(-20, 20)
		new_enemy.position = Vector3(rand_x, 0.5, rand_z)
		
		add_child(new_enemy)
		new_enemy.add_to_group("Enemies")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
