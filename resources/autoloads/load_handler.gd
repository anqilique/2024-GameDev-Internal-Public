extends Node


signal progress_changed(progress)
signal loaded

var loadscreen_path : String = "res://scenes/gui/load_screen.tscn"
var loadscreen = load(loadscreen_path)
var loaded_resource : PackedScene
var scene_path : String
var progress : Array = []

var use_sub_threads : bool = false


func load_scene(path: String) -> void:
	scene_path = path
	
	var new_loadingscreen = loadscreen.instantiate()
	get_tree().get_root().add_child(new_loadingscreen)
	
	self.progress_changed.connect(new_loadingscreen.update_progress_bar)
	self.loaded.connect(new_loadingscreen.start_exit_animation)
	
	await Signal(new_loadingscreen, "loadingscreen_has_full_coverage")
	
	start_load()


func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK: set_process(true)
	

func _process(delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	match load_status:
		0, 2:  # Failed to load.
			set_process(false)
			return
		1: emit_signal("progress_changed", progress[0])  # Loading...
		3:  # Loaded.
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			emit_signal("progress_changed", 1.0)
			emit_signal("loaded")
			
			get_tree().change_scene_to_packed(loaded_resource)
