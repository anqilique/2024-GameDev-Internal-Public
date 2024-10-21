extends Node

var save_path = "user://score.save"
var new_high_set = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_high_score():
	var high_score
	
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		high_score = file.get_var()
	else:
		high_score = 0
	
	return high_score


func save_high_score(current_score):
	var high_score = load_high_score()
	
	if current_score > high_score:
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		
		new_high_set = true
		file.store_var(current_score)
	
	else:
		new_high_set = false
