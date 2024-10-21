extends Node

var save_path = "user://score.save"
var new_high_set = false


func load_high_score():
	var high_score
	
	# Check if a save file exists.
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		high_score = file.get_var()  # Get score from save.
	else:
		high_score = 0  # Set score to default.
	
	return high_score


func save_high_score(current_score):
	var high_score = load_high_score()
	
	# If new score is higher than saved value.
	if current_score > high_score:
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		
		new_high_set = true
		file.store_var(current_score)  # Save new score.
	
	else:
		new_high_set = false
