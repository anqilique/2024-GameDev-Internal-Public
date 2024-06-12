extends State
class_name EnemyTakeDMG

const DAMAGED_SPEED = 0.08
const SPEED = 0.1

var enemy

func enter():
	enemy = get_parent().get_parent()
	enemy.get_node("RecoveryTimer").start()
	
	print("Ouch Damage!")
