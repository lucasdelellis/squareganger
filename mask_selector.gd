extends Control

@onready var mask_container: GridContainer = $MaskContainer
const MASK_SCENE = preload("res://scenes/mask.tscn")

func render_masks(mask_data: Array) -> void:
	clear_masks()
	
	for data in mask_data:
		var mask_instance = MASK_SCENE.instantiate()
		mask_container.add_child(mask_instance)
		
		var mask_id: int = data.get("maskId", -1)
		var image_path: String = data.get("imagePath", "")
		
		mask_instance.initialize(mask_id, image_path)

func clear_masks() -> void:
	for child in mask_container.get_children():
		child.queue_free()
