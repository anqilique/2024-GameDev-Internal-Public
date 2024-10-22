"""
From Loading Screen Tutorial: @Queble
	https://www.youtube.com/watch?v=Wnkc_qUXYWs
"""

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
	scene_path = path  # Set the destination.
	
	var new_loadingscreen = loadscreen.instantiate()
	get_tree().get_root().add_child(new_loadingscreen)
	
	# Connect signals.
	self.progress_changed.connect(new_loadingscreen.update_progress_bar)
	self.loaded.connect(new_loadingscreen.start_exit_animation)
	
	# Wait until loading screen has loaded.
	await Signal(new_loadingscreen, "loadingscreen_has_full_coverage")
	
	start_load()


func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:  # If there are no errors with this request.
		set_process(true)
	

func _process(_delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	
	match load_status:
		0, 2:  # Failed to load scene.
			set_process(false)
			return
			
		1:  # Scene is loading...
			emit_signal("progress_changed", progress[0])
		
		3:  # Scene has loaded.
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			emit_signal("progress_changed", 1.0)
			emit_signal("loaded")
			
			get_tree().change_scene_to_packed(loaded_resource)
