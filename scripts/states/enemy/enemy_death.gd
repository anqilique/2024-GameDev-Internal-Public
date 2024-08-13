extends State
class_name EnemyDeath

var enemy

@export var health_collectable_scene : PackedScene
@export var essence_collectable_scene : PackedScene

func enter():
	enemy = get_parent().get_parent()
	
	"""
	Enemy Drops Health
	"""
	
	var new_health_drop = health_collectable_scene.instantiate()
	
	new_health_drop.position = enemy.position
	new_health_drop.position.y += 2
	
	new_health_drop.add_to_group("Health Collectables")
	
	# Spawn the health collectable.
	enemy.add_sibling(new_health_drop)
	
	"""
	Enemy Drops Essence
	"""
	
	var new_essence_drop = essence_collectable_scene.instantiate()
	
	new_essence_drop.position = enemy.position
	new_essence_drop.position.y += 3  # Don't spawn on top of health collectable.
	
	new_essence_drop.add_to_group("Essence Collectables")
	
	# Spawn the essence collectable.
	enemy.add_sibling(new_essence_drop)
	
	"""
	Free the Enemy Node
	"""
	enemy.queue_free()
	PlayerVars.live_enemies -= 1
