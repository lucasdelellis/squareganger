extends TextureRect

signal accept_pressed()
signal reject_pressed()

func _on_accept_pressed() -> void:
	$Accept/Click.play()
	await get_tree().create_timer(0.2).timeout
	accept_pressed.emit()

func _on_reject_pressed() -> void:
	$Reject/Click.play()
	await get_tree().create_timer(0.2).timeout
	reject_pressed.emit()


func _on_reject_mouse_entered() -> void:
	$Reject.scale = Vector2(1.1, 1.1)

func _on_reject_mouse_exited() -> void:
	$Reject.scale = Vector2(1.0, 1.0)

func _on_accept_mouse_entered() -> void:
	$Accept.scale = Vector2(1.1, 1.1)

func _on_accept_mouse_exited() -> void:
	$Accept.scale = Vector2(1.0, 1.0)
