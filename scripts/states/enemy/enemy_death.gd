extends State
class_name EnemyDeath

var enemy

@export var health_collectable_scene : PackedScene
@export var essence_collectable_scene : PackedScene
@export var exp_collectable_scene : PackedScene


func enter():
	enemy = get_parent().get_parent()
	AudioHandler.play_sound("EnemyDeath")
	
	"""
	Enemy Drops Health (2-4 Collectables)
	"""
	
	for i in randi_range(2, 4):
		var new_health_drop = health_collectable_scene.instantiate()
		
		new_health_drop.position = enemy.position
		new_health_drop.position.y += 2
		
		new_health_drop.add_to_group("Health Collectables")
		
		# Spawn the health collectable.
		enemy.add_sibling(new_health_drop)
	
	"""
	Enemy Drops Essence (1-5 Collectables)
	"""
	
	for i in randi_range(1, 5):
		var new_essence_drop = essence_collectable_scene.instantiate()
		
		new_essence_drop.position = enemy.position
		new_essence_drop.position.y += 3
		
		new_essence_drop.add_to_group("Essence Collectables")
		
		# Spawn the essence collectable.
		enemy.add_sibling(new_essence_drop)
	
	"""
	Enemy Drops Experience
	"""
	
	var new_exp_drop = exp_collectable_scene.instantiate()
		
	new_exp_drop.position = enemy.position
	new_exp_drop.position.y += 5
	
	new_exp_drop.add_to_group("Experience Collectables")
	
	# Spawn the experience collectable.
	enemy.add_sibling(new_exp_drop)
	
	"""
	Free the Enemy Node
	"""
	
	enemy.queue_free()
	PlayerVars.live_enemies -= 1
