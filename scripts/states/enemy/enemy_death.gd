extends State
class_name EnemyDeath

var enemy

func enter():
	enemy = get_parent().get_parent()
	enemy.queue_free()
