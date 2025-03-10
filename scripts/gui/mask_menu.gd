extends Control

const SHORTCUT = "ui_right_mouse_button"
const SLOWED_SPEED = 0.2

var change_mask_to
var available_masks


# Called when the node enters the scene tree for the first time.
func _ready():
	change_mask_to = PlayerVars.current_mask
	available_masks = PlayerVars.masks
	hide_menu()


func show_menu(location):
	"""
	Return because this means only one mask is available.
	Therefore there is nothing other option to switch to.
	"""
	
	if PlayerVars.broken_masks.size() >= 4: return
	
	"""
	Otherwise...
	"""
	
	position = location  # Go to mouse position.
	Engine.time_scale = SLOWED_SPEED  # Slow game down.
	$CanvasLayer.visible = true  # Blur the background.
	show()


func hide_menu():
	Engine.time_scale = 1  # Set game to normal speed.
	$CanvasLayer.visible = false  # Unblur background.
	hide()
	
	# Update the current mask.
	if (
		PlayerVars.current_mask != change_mask_to
		and change_mask_to not in PlayerVars.broken_masks
	):
		PlayerVars.current_mask = change_mask_to
	
	var mask_data = MaskVars.get_mask_from_num()
	
	# Some masks have bonuses to maximum health, update it.
	if PlayerVars.max_health != PlayerVars.base_max_health + mask_data["max_health_bonus"]:
		PlayerVars.max_health = PlayerVars.base_max_health + mask_data["max_health_bonus"]


func mask_selected(button):
	if button not in PlayerVars.broken_masks:
		change_mask_to = button


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (  # If not dead and shortcut is pressed.
		Input.is_action_just_pressed(SHORTCUT)
		and PlayerVars.current_health > 0
		):

		# Check there is the correct number of available masks left.
		available_masks = []
		for mask in PlayerVars.masks:
			if mask not in PlayerVars.broken_masks:
				available_masks.append(mask)
				
				# Show available masks.
				get_node(str(mask)).show()
			
			else:  # Hide broken masks.
				get_node(str(mask)).hide()
			
			var get_mouse_pos = get_global_mouse_position()
			show_menu(get_mouse_pos)  # Show menu at mouse.
	
	elif (
		Input.is_action_just_released(SHORTCUT)
		or is_visible() and not Input.is_action_pressed(SHORTCUT)
		):
		
		hide_menu()


"""
Mask Button Signals
"""

func _on_1_mouse_entered():
	mask_selected(1)

func _on_2_mouse_entered():
	mask_selected(2)

func _on_3_mouse_entered():
	mask_selected(3)

func _on_4_mouse_entered():
	mask_selected(4)

func _on_5_mouse_entered():
	mask_selected(5)
