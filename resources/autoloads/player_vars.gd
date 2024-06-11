extends Node

# Movement related variables.
var speed = 12
var jump_velocity = 6
var jump_max_count = 1

# Mask related variables.
var current_mask
var masks = {
	"1" : [],
	"2" : [],
	"3" : [],
	"4" : [],
	"5" : []
}

# Health related variables.
var current_health
var max_health

# Attack related variables.
var attack_damage = 10
