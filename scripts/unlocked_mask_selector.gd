extends Node

signal mask_selected()

@onready var mask_container: GridContainer = $MaskContainer
@onready var left_arrow: TextureButton = $LeftArrow
@onready var right_arrow: TextureButton = $RightArrow

const MASK_SCENE = preload("res://scenes/mask.tscn")
const MAX_VISIBLE_MASKS = 3
const MAX_SELECTABLE_MASKS = 2

var all_masks_data: Array = []
var current_offset: int = 0
var selected_masks: Array = []

func render_masks(mask_data: Array) -> void:
	all_masks_data = mask_data
	current_offset = 0
	update_display()

func update_display() -> void:
	clear_masks()
	
	var visible_count = min(MAX_VISIBLE_MASKS, all_masks_data.size())
	for i in range(visible_count):
		var index = (current_offset + i) % all_masks_data.size()
		var data = all_masks_data[index]
		
		var mask_instance = MASK_SCENE.instantiate()
		mask_container.add_child(mask_instance)
		
		var mask_id: int = data.get("maskId", -1)
		var image_path: String = data.get("imagePath", "")
		
		mask_instance.initialize(mask_id, image_path)
		mask_instance.mask_selected.connect(_on_mask_selected)
	
	update_arrows_visibility()

func update_arrows_visibility() -> void:
	var should_show_arrows = all_masks_data.size() > MAX_VISIBLE_MASKS
	left_arrow.visible = should_show_arrows
	right_arrow.visible = should_show_arrows
	left_arrow.disabled = not should_show_arrows
	right_arrow.disabled = not should_show_arrows

func scroll_left() -> void:
	if all_masks_data.size() > MAX_VISIBLE_MASKS:
		current_offset = (current_offset - 1 + all_masks_data.size()) % all_masks_data.size()
		update_display()

func scroll_right() -> void:
	if all_masks_data.size() > MAX_VISIBLE_MASKS:
		current_offset = (current_offset + 1) % all_masks_data.size()
		update_display()

func clear_masks() -> void:
	for child in mask_container.get_children():
		child.queue_free()
		
func _on_mask_selected(id: int):
	if not selected_masks.has(id) and len(selected_masks) < MAX_SELECTABLE_MASKS:
		selected_masks.append(id)
		GameState.masks.clear()
		GameState.masks.append_array(selected_masks)
		mask_selected.emit()

func _on_left_arrow_pressed() -> void:
	scroll_left()

func _on_right_arrow_pressed() -> void:
	scroll_right()
