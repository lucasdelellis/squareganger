extends TextureRect

signal mask_selected(mask_id: int)

var mask_id: int = -1

func _ready() -> void:
	custom_minimum_size = Vector2(100, 100)
	pivot_offset = Vector2(50, 50)
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	# Ensure the mouse doesn't "pass through" the texture
	mouse_filter = Control.MOUSE_FILTER_STOP

func initialize(p_mask_id: int, image_path: String) -> void:
	mask_id = p_mask_id
	var tex = load(image_path)
	if tex:
		texture = tex
	else:
		push_error("Failed to load mask image: " + image_path)

# This replaces the _on_pressed() from the TextureButton
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mask_selected.emit(mask_id)
			# Visual feedback for click
			_pulse_animation()

# --- Hover Animations ---

func _on_mouse_entered() -> void:
	# Create a smooth "pop" effect using a Tween
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(self, "modulate", Color(1.2, 1.2, 1.2), 0.1)

func _on_mouse_exited() -> void:
	# Smoothly return to original state
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(self, "modulate", Color(1, 1, 1), 0.1)

func _pulse_animation() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.05)
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.05)
