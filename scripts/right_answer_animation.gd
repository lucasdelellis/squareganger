extends CanvasLayer

signal animation_finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var animation_duration: float = 1.5

func _ready() -> void:
	hide()
	# Update animation speed based on duration
	if animation_player and animation_player.has_animation("show_right_answer"):
		var speed_scale = 1.5 / animation_duration
		animation_player.speed_scale = speed_scale

func play_animation() -> void:
	show()
	print("hola")
	animation_player.play("show_right_answer")

func _on_animation_player_animation_finished(anim_name: String) -> void:
	if anim_name == "show_right_answer":
		hide()
		animation_finished.emit()
