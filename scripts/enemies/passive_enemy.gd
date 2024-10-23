extends CharacterBody3D

@export var statetimer_min : float
@export var statetimer_max : float
@onready var time_in_state : float

@onready var state_machine = $StateMachine
@onready var animator = $AnimationPlayer
@onready var particles = $Rig/CPUParticles3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	$HealthBar.hide()
	
	$HealthComponent.max_health = randi_range(30, 40)
	$HealthComponent.health = $HealthComponent.max_health
	$HealthBar.set_values()
	
	reset_statetimer()


func reset_statetimer():  # Randomize time spent in state.
	time_in_state = randf_range(statetimer_min, statetimer_max)
	$StateTimer.wait_time = time_in_state
	$StateTimer.start()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if state_machine.current_state.name == "EnemyIdle":
		if animator.is_playing():
			animator.play("RESET")
			animator.stop()
			
			if particles.emitting:
				particles.emitting = false
			
	elif not animator.is_playing():
			animator.play("move")
			
			if not particles.emitting:
				particles.emitting = true
	
	move_and_slide()


func go_to_state(new_state):
	state_machine.on_child_transition(state_machine.current_state, new_state)


func switch_state(current_state):  # Switch between idling/wandering.
	if current_state == "EnemyIdle":
		go_to_state("EnemyWander")
	elif current_state == "EnemyWander":
		go_to_state("EnemyIdle")
	
	# Randomize the time spent in state.
	if current_state != "EnemyDeath":
		reset_statetimer()


func _on_state_timer_timeout():
	switch_state(state_machine.current_state.name)


func _on_hitbox_3d_body_entered(body):
	if body.name == "Player":  # If player in range and alive.
		if body.get_node("StateMachine").current_state.name != "PlayerDeath":
			go_to_state("EnemyAttack")


func _on_hitbox_3d_body_exited(body):
	if body.name == "Player":  # If player leaves the enemy's detect range.
		go_to_state("EnemyIdle")
