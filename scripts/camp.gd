extends Node3D

@onready var camp_environment = $Environment

# Called when the node enters the scene tree for the first time.
func _ready():
	for mask in camp_environment.get_node("Masks").get_children():
		mask.get_node("AnimationPlayer").play("rotate_slow")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
