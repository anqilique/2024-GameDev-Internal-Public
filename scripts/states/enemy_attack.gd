extends State
class_name EnemyAttack

@export var attack_cooldown : float

var enemy

func enter():
	enemy = get_parent().get_parent()
	enemy.get_node("AttackTimer").wait_time = attack_cooldown

func update(delta):
	if enemy.get_node("AttackTimer").is_stopped():
		print("Deal Damage")
		enemy.get_node("AttackTimer").start()
