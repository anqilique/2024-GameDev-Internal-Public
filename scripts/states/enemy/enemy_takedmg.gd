extends State
class_name EnemyTakeDMG

const DAMAGED_SPEED = 0.08
const SPEED = 0.1

var enemy

func enter():
	enemy = get_parent().get_parent()
	enemy.get_node("RecoveryTimer").start()
	
	print("Ouch Damage!")


func _on_recovery_timer_timeout():
	var state_machine = enemy.get_node("StateMachine")
	state_machine.on_child_transition(state_machine.current_state, "EnemyIdle")
