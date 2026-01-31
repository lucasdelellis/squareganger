extends TextureButton

signal mask_selected(mask_id: int)

var mask_id: int = -1

func initialize(p_mask_id: int, image_path: String) -> void:
	mask_id = p_mask_id
	var texture = load(image_path)
	if texture:
		texture_normal = texture
	else:
		push_error("Failed to load mask image: " + image_path)

func _on_pressed() -> void:
	mask_selected.emit(mask_id)
