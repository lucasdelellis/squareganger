extends Node

const MAIN_SCENE = preload("res://scenes/game_manager.tscn")

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_SCENE)
