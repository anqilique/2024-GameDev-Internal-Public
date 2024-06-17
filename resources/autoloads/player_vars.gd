extends Node

# Movement related variables.
var speed = 12
var jump_velocity = 6
var jump_max_count = 1

# Mask related variables.
var current_mask = 5
var masks = {  # "No. Code" : []
	1 : [],
	2 : [],
	3 : [],
	4 : [],
	5 : []
}

# Health related variables.
var current_health = 100
var max_health = 100

var starting_health = 100

# Attack related variables.
var attack_damage = 10
