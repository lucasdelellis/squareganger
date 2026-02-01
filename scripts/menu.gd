extends Node

const MAIN_SCENE = preload("res://scenes/game_manager.tscn")
const TOTURIAL_SCENE = preload("res://scenes/tutorial.tscn")
const CREDITS_SCENE = preload("res://scenes/credits.tscn")

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_SCENE)
	
func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_packed(TOTURIAL_SCENE)

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_packed(CREDITS_SCENE)
