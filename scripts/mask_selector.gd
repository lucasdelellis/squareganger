extends Control

signal mask_selected(id: int)
signal deactivate_masks
signal activate_masks

@onready var mask_container: GridContainer = $MaskContainer
@onready var left_arrow: TextureButton = $LeftArrow
@onready var right_arrow: TextureButton = $RightArrow

const MASK_SCENE = preload("res://scenes/mask.tscn")
const MAX_VISIBLE_MASKS = 3

var all_masks_data: Array = []
var current_offset: int = 0
@export var max_mask_selections = 3
var last_mask_selected 
	
func _on_activate_masks():
	max_mask_selections = 3
	last_mask_selected = 0
	activate_masks.emit()

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
		
		#connect signals
		activate_masks.connect(mask_instance._on_activate_masks)
		deactivate_masks.connect(mask_instance._on_deactivate_masks)
		
		var mask_id: int = data.get("maskId", -1)
		var image_path: String = data.get("imagePath", "")
		
		mask_instance.initialize(mask_id, image_path)
		mask_instance.mask_selected.connect(_on_mask_selected)
	
	update_arrows_visibility()

func update_arrows_visibility() -> void:
	var should_show_arrows = all_masks_data.size() >= 4
	left_arrow.visible = should_show_arrows
	right_arrow.visible = should_show_arrows
	left_arrow.disabled = not should_show_arrows
	right_arrow.disabled = not should_show_arrows

func scroll_left() -> void:
	if all_masks_data.size() >= 4:
		current_offset = (current_offset - 1 + all_masks_data.size()) % all_masks_data.size()
		update_display()

func scroll_right() -> void:
	if all_masks_data.size() >= 4:
		current_offset = (current_offset + 1) % all_masks_data.size()
		update_display()

func clear_masks() -> void:
	for child in mask_container.get_children():
		child.queue_free()

func _on_mask_selected(id: int):
	if max_mask_selections > 0 and last_mask_selected != id: 
		max_mask_selections -= 1
		last_mask_selected = id
		mask_selected.emit(id)
	elif max_mask_selections == 0:
		deactivate_masks.emit()

func _on_left_arrow_pressed() -> void:
	$LeftArrow/Click.play()
	await get_tree().create_timer(0.2).timeout
	scroll_left()

func _on_right_arrow_pressed() -> void:
	$RightArrow/Click.play()
	await get_tree().create_timer(0.2).timeout
	scroll_right()
