extends Node

# Movement related variables.
var base_speed = 12

var jump_velocity = 6
var jump_max_count = 1

# Mask related variables.
var current_mask = 5
var masks = {  # Code No. : "File Path"
	1 : "res://resources/masks/dragon_mask.tres",
	2 : "res://resources/masks/bird_mask.tres",
	3 : "res://resources/masks/tiger_mask.tres",
	4 : "res://resources/masks/tortoise_mask.tres",
	5 : "res://resources/masks/qilin_mask.tres"
}

# Health related variables.
var current_health = 100
var max_health = 100
var base_max_health = 100

var starting_health = 100

# Attack related variables.
var attack_damage = 10
