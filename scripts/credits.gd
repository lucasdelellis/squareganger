extends TextureRect

const MENU_SCENE = "res://scenes/menu.tscn"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)
