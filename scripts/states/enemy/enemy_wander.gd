extends State
class_name EnemyWander

const SPEED = 0.1

var enemy
var moving
var direction

var movement_dict = {
	"FORWARD" : -1,
	"BACKWARD" : 1,
	"LEFT" : 1,
	"RIGHT" : -1,
}

func enter():
	enemy = get_parent().get_parent()
	direction = movement_dict.keys().pick_random()
	

func physics_update(_delta):
	# Move in the random direction previously chosen.
	if direction in ["FORWARD", "BACKWARD"]:
		enemy.velocity.z += SPEED * movement_dict[direction]
	elif direction in ["LEFT", "RIGHT"]:
		enemy.velocity.x += SPEED * movement_dict[direction]
		
	enemy.look_at(enemy.global_transform.origin + enemy.velocity)
	enemy.move_and_slide()
