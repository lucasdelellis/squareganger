extends Node

const MAIN_SCENE = preload("res://scenes/game_manager.tscn")
const TOTURIAL_SCENE = preload("res://scenes/tutorial.tscn")
const CREDITS_SCENE = preload("res://scenes/credits.tscn")

func _on_start_button_pressed() -> void:
	$StartButton/Click.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_packed(MAIN_SCENE)
	
func _on_tutorial_button_pressed() -> void:
	$TutorialButton/Click.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_packed(TOTURIAL_SCENE)

func _on_credits_button_pressed() -> void:
	$CreditsButton/Click.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_packed(CREDITS_SCENE)

func _on_start_button_mouse_entered() -> void:
	$StartButton.scale = Vector2(1.1, 1.1)

func _on_start_button_mouse_exited() -> void:
	$StartButton.scale = Vector2(1.0, 1.0)

func _on_tutorial_button_mouse_entered() -> void:
	$TutorialButton.scale = Vector2(1.1, 1.1)

func _on_tutorial_button_mouse_exited() -> void:
	$TutorialButton.scale = Vector2(1.0, 1.0)

func _on_credits_button_mouse_entered() -> void:
	$CreditsButton.scale = Vector2(1.1, 1.1)

func _on_credits_button_mouse_exited() -> void:
	$CreditsButton.scale = Vector2(1.0, 1.0)
