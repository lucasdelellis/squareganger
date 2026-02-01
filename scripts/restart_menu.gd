extends Node

var MAIN_SCENE = "res://scenes/game_manager.tscn"
const MASK_PATH = 'res://assets/masks/m'

var left_mask = -1
var right_mask = -1

func _ready() -> void:
	var masks = []
	for mask_id in GameState.obtained_masks:
		masks.append({"maskId": mask_id, "imagePath": get_mask_img(mask_id)})
	$UnlockedMaskSelector.render_masks(masks)
	$UnlockedMaskSelector.mask_selected.connect(_on_mask_selected)
	$UnlockedMaskSelector.mask_deselected.connect(_on_mask_deselected)
	$Score.text = str(GameState.score)

func reset_game_state():
	GameState.score = 0
	GameState.masks = [left_mask, right_mask]
	GameState.obtained_masks = [left_mask, right_mask]

func _on_restart_button_pressed() -> void:
	if left_mask != -1 and right_mask != -1:
		reset_game_state()
		get_tree().change_scene_to_file(MAIN_SCENE)
	
func get_mask_img(n: int):
	return MASK_PATH + str(n) + '.png'

func _on_mask_selected(id: int):
	var texture = load(get_mask_img(id))
	if left_mask == -1:
		$LeftMask.texture = texture
		left_mask = id
	else:
		$RightMask.texture = texture
		right_mask = id
		
func _on_mask_deselected(id: int):
	if left_mask == id:
		$LeftMask.texture = null
		left_mask = -1
	elif right_mask == id:
		$RightMask.texture = null
		right_mask = -1
