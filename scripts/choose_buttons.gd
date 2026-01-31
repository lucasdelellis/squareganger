extends TextureRect

signal accept_pressed()
signal reject_pressed()

func _on_accept_pressed() -> void:
	accept_pressed.emit()


func _on_reject_pressed() -> void:
	reject_pressed.emit()
