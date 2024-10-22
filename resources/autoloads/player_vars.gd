extends Node


var respawn_with_progress = false

# Battle related variables.
var wave = 0
var live_enemies = 0
var starting_waves = [[1, 0], [1, 1], [2, 1], [1, 2], [2, 2], [3, 2], [4, 2]]

# Movement related variables.
var base_speed = 8

var jump_velocity = 8
var jump_max_count = 1

# Mask related variables.
var broken_masks = []
var current_mask = 5
var masks = [1, 2, 3, 4, 5]

# Health related variables.
var current_health = 100
var max_health = 100
var base_max_health = 100

var starting_health = 100

# Attack related variables.
var attack_damage = 15

# Currency related variables.
var essence = 10

# Experience related variables.
var level = 1
var current_exp = 0
var max_exp = 2

# Score related variables.
var lifetime = 0
var score = 0


func reset_to_defaults():
	MaskVars.reset_to_defaults()
	
	respawn_with_progress = false
	
	# Battle related variables.
	wave = 0
	live_enemies = 0
	starting_waves = [[1, 0], [1, 1], [2, 1], [1, 2], [2, 2], [3, 2], [4, 2]]

	# Movement related variables.
	base_speed = 8

	jump_velocity = 8
	jump_max_count = 1

	# Mask related variables.
	broken_masks = []
	current_mask = 5
	masks = [1, 2, 3, 4, 5]

	# Health related variables.
	current_health = 100
	max_health = 100
	base_max_health = 100

	starting_health = 100

	# Attack related variables.
	attack_damage = 15

	# Currency related variables.
	essence = 10

	# Experience related variables.
	level = 1
	current_exp = 0
	max_exp = 2

	# Score related variables.
	lifetime = 0
	score = 0
