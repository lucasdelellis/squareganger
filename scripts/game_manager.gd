extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hud/MaskSelector.render_masks([{"maskId": 1, "imagePath": "res://assets/masks/m1.png"}, {"maskId": 2, "imagePath": "res://assets/masks/m2.png"}])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
