extends Node


var respawn_with_progress = true

# Battle related variables.
var wave = 0
var live_enemies = 0
var starting_waves = [[1, 0], [1, 1], [2, 1], [4, 2]]

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
var essence = 0

# Experience related variables.
var level = 1
var current_exp = 0
var max_exp = 2
var req_exp = max_exp - current_exp

# Score related variables.
var lifetime = 0
