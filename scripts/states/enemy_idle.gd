extends State
class_name EnemyIdle

var enemy

func enter():
	enemy = get_parent().get_parent()
	

func physics_update(delta):
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, 12)
	enemy.velocity.z = move_toward(enemy.velocity.z, 0, 12)
	
	enemy.move_and_slide()

