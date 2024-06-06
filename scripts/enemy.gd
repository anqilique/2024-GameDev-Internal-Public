extends CharacterBody3D

@export var statetimer_min : float
@export var statetimer_max : float

@onready var time_in_state : float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	reset_statetimer()

func reset_statetimer():
	time_in_state = randf_range(statetimer_min, statetimer_max)
	$StateTimer.wait_time = time_in_state
	$StateTimer.start()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()

func go_to_new_state(current_state):
	if current_state == "EnemyIdle":
		$StateMachine.on_child_transition($StateMachine.current_state, "EnemyWander")
	elif current_state == "EnemyWander":
		$StateMachine.on_child_transition($StateMachine.current_state, "EnemyIdle")
	
	reset_statetimer()


func _on_state_timer_timeout():
	go_to_new_state($StateMachine.current_state.name)


func _on_hitbox_3d_body_entered(body):
	if body.name == "Player":
		print("Switching to Attack State!")
		$StateMachine.on_child_transition($StateMachine.current_state, "EnemyAttack")


func _on_hitbox_3d_body_exited(body):
	if body.name == "Player":
		print("Switching to Idle State!")
		$StateMachine.on_child_transition($StateMachine.current_state, "EnemyIdle")
