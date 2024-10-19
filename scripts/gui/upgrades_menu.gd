extends Control

@onready var current_mask_upgraded = $UpgradePanel/MaskUpgrades.text

var mask_index = 5

var upgrade_value = PlayerVars.level
var base_upgrade_cost = upgrade_value * 4
var mask_upgrade_cost = upgrade_value * 2

var insufficient_essence_msg = "[center]Not Enough Essence!"


var mask_colours_dict = {
	1 : Settings.blue,
	2 : Settings.red,
	3 : Settings.white,
	4 : Settings.green,
	5 : Settings.yellow,
}

var mask_dict = {
	"Mask of Swiftness" : 1,
	"Mask of Flight" : 2,
	"Mask of Fury" : 3,
	"Mask of Healing" : 4,
	"Mask of Balance" : 5,
}


func update_player_stats_panel():
	var label = $PlayerStatsPanel/RichTextLabel
	var mask_text_colours = []
	
	update_costs(false)
	
	mask_index = mask_dict.keys().find(current_mask_upgraded) + 1
	
	$UpgradePanel/MaskUpgrades.modulate = mask_colours_dict[mask_index]
	
	# Determine the colours of the mask strings.
	for mask in PlayerVars.masks:
		if mask in PlayerVars.broken_masks:
			mask_text_colours.append("FFFFFF78")
		else:
			mask_text_colours.append(mask_colours_dict[mask])
	
	var new_text = (  # Format the entire label.
		"[center] %d Essence\n\n" % PlayerVars.essence
		+ "Level %d\n" % PlayerVars.level
		+ "Wave %d\n\n" % PlayerVars.wave
		+ "%d Base Health\n" % PlayerVars.base_max_health
		+ "%d Base Speed\n" % PlayerVars.base_speed
		+ "%d Base Damage\n\n" % PlayerVars.attack_damage
		+ "[color=%s]Mask of Swiftness[/color]\n" % mask_text_colours[0]
		+ "[color=%s]Mask of Flight[/color]\n" % mask_text_colours[1]
		+ "[color=%s]Mask of Fury[/color]\n" % mask_text_colours[2]
		+ "[color=%s]Mask of Healing[/color]\n" % mask_text_colours[3]
		+ "[color=%s]Mask of Balance[/color]\n\n" % mask_text_colours[4]
		+ "%d Broken Masks" % len(PlayerVars.broken_masks)
	)
	
	label.text = new_text


func update_costs(update_text):
	var cost_text = "[center]Upgrade Costs: Base = %d | Mask = %d Essence"
	upgrade_value = PlayerVars.level
	
	base_upgrade_cost = upgrade_value * 6
	mask_upgrade_cost = upgrade_value * 4
	
	cost_text = cost_text % [base_upgrade_cost, mask_upgrade_cost]
	
	if update_text:
		$ActivityPanel/RichTextLabel.text = cost_text


func handle_mask_resource():
	pass


func handle_upgrade(type, attribute):
	var new_exchange_label
	
	match type:
		"base" :  # If upgrading base stats.
			
			if PlayerVars.essence < base_upgrade_cost:
				$ActivityPanel/RichTextLabel.text = insufficient_essence_msg
				return
			
			PlayerVars.essence -= base_upgrade_cost
			
			match attribute:
				"max_health_bonus" : PlayerVars.base_max_health += upgrade_value
				"movement_speed_bonus" : PlayerVars.base_speed += upgrade_value
				"attack_damage_bonus" : PlayerVars.attack_damage += upgrade_value
		
		"mask" :  # If upgrading stats of a mask.
			
			if PlayerVars.essence < mask_upgrade_cost:
				$ActivityPanel/RichTextLabel.text = insufficient_essence_msg
				return
			
			PlayerVars.essence -= mask_upgrade_cost
			
			match current_mask_upgraded:
				"Mask of Swiftness" : MaskVars.swiftness_mask[attribute] += upgrade_value
				"Mask of Flight" : MaskVars.flight_mask[attribute] += upgrade_value
				"Mask of Fury" : MaskVars.fury_mask[attribute] += upgrade_value
				"Mask of Healing" : MaskVars.healing_mask[attribute] += upgrade_value
				"Mask of Balance" : MaskVars.balance_mask[attribute] += upgrade_value
	
	PlayerVars.current_health = PlayerVars.base_max_health + MaskVars.get_mask_from_num()["max_health_bonus"]
	
	new_exchange_label = "[center]Last Exchange: Upgrade %s %s +%d" % [type, attribute, upgrade_value]
	$ActivityPanel/RichTextLabel.text = new_exchange_label
	
	update_player_stats_panel()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_stats_panel()
	update_costs(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mask_upgrades_pressed() -> void:
	if mask_index == 5:
		mask_index = 1
	else:
		mask_index += 1
	
	current_mask_upgraded = mask_dict.find_key(mask_index)
	
	$UpgradePanel/MaskUpgrades.text = current_mask_upgraded
	$UpgradePanel/MaskUpgrades.modulate = mask_colours_dict[mask_index]


func _on_return_button_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_base_health_pressed() -> void:
	handle_upgrade("base", "max_health_bonus")


func _on_base_speed_pressed() -> void:
	handle_upgrade("base", "movement_speed_bonus")


func _on_base_damage_pressed() -> void:
	handle_upgrade("base", "attack_damage_bonus")


func _on_mask_health_pressed() -> void:
	handle_upgrade("mask", "max_health_bonus")


func _on_mask_speed_pressed() -> void:
	handle_upgrade("mask", "movement_speed_bonus")


func _on_mask_damage_pressed() -> void:
	handle_upgrade("mask", "attack_damage_bonus")


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	update_player_stats_panel()
	update_costs(true)
