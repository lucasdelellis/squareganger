extends TextureRect

const MENU_SCENE = "res://scenes/menu.tscn"

func _on_button_pressed() -> void:
	$Button/Click.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file(MENU_SCENE)

func _on_button_mouse_entered() -> void:
	$Button.scale = Vector2(1.1,1.1)

func _on_button_mouse_exited() -> void:
	$Button.scale = Vector2(1.0,1.0)
