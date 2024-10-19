extends Node

"""
Masks provide bonuses to attributes when worn.
"""

func get_mask_from_num():
	match PlayerVars.current_mask:
		1 : return swiftness_mask
		2 : return flight_mask
		3 : return fury_mask
		4 : return healing_mask
		5 : return balance_mask

# Mask of Flight
var flight_mask = {
	"max_health_bonus" : -5,
	"movement_speed_bonus" : 20,
	"attack_damage_bonus" : 5,
}

# Mask of Swiftness
var swiftness_mask = {
	"max_health_bonus" : 0,
	"movement_speed_bonus" : 10,
	"attack_damage_bonus" : 10,
}

# Mask of Balance
var balance_mask = {
	"max_health_bonus" : 10,
	"movement_speed_bonus" : 5,
	"attack_damage_bonus" : 5,
}

# Mask of Fury
var fury_mask = {
	"max_health_bonus" : 5,
	"movement_speed_bonus" : 0,
	"attack_damage_bonus" : 10,
}

# Mask of Healing
var healing_mask = {
	"max_health_bonus" : 15,
	"movement_speed_bonus" : -5,
	"attack_damage_bonus" : -5,
}
