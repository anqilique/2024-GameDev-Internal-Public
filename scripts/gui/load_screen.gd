extends CanvasLayer

signal loadingscreen_has_full_coverage

@onready var animator : AnimationPlayer = $AnimationPlayer
@onready var progress_bar : ProgressBar = $ProgressBar


func _ready():
	$RichTextLabel.text = "[center]Loading... Tip: %s" % Settings.tips.pick_random()
	animator.play("start_load")


func update_progress_bar(new_value: float) -> void:
	var bar = $ProgressBar
	var tween = get_tree().create_tween()
	new_value *= 100
	
	tween.tween_property(bar, "value", new_value, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.bind_node(self)


func start_exit_animation() -> void:
	animator.play("end_load")
	
	await Signal(animator, "animation_finished")
	self.queue_free()
