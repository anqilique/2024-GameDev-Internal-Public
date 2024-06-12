extends State
class_name EnemyChase

const SPEED = 0.1

var enemy
var player
var moving

func enter():
	enemy = get_parent().get_parent()
	player = get_tree().get_first_node_in_group("Player")

func physics_update(_delta):
	enemy.move_and_slide()
