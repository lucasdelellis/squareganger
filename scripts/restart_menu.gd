extends Node

var MAIN_SCENE = "res://scenes/game_manager.tscn"
const MASK_PATH = 'res://assets/masks/m'
#var player_masks: Array[int] = GameState.masks
#var selected_masks : Array[int] = [1,2] 

func _ready() -> void:
	#set_masks()
	var masks = []
	for mask_id in [1,2,3,4,5]:
		masks.append({"maskId": mask_id, "imagePath": get_mask_img(mask_id)})
	$UnlockedMaskSelector.render_masks(masks)
	$UnlockedMaskSelector.mask_selected.connect(_on_mask_selected)
	$Score.text = str(GameState.score)

#func set_masks():
	#var masks = []
	#print(player_masks)
	#for mask_id in player_masks:
		#masks.append({"maskId": mask_id, "imagePath": get_mask_img(mask_id)})
	#print(masks)	
	#$MaskSelector.render_masks(masks)
	#$MaskSelector.mask_selected.connect(_on_mask_selected)

func reset_game_state():
	GameState.score = 0
	#GameState.masks = selected_masks
	#GameState.obtained_masks = selected_masks

func _on_restart_button_pressed() -> void:
	print("Back to main")
	reset_game_state()
	get_tree().change_scene_to_file(MAIN_SCENE)
	
#func _on_mask_selected(id: int): #it may work
	#print(id)
	#var mask_path = get_mask_img(id)
	##Mask selection
	#if GameState.masks.has(id):
		#GameState.masks.erase(id)
		#$SelectedMasks.eliminate_mask(id)
	#else:
		#if GameState.masks.size()<2:
			#GameState.masks.append(id)
			#$SelectedMasks.set_mask(id)
	
func get_mask_img(n: int):
	return MASK_PATH + str(n) + '.png'

func _on_mask_selected():
	var selected_masks = $UnlockedMaskSelector.selected_masks
	if len(selected_masks) >= 1:
		$LeftMask.texture = load(get_mask_img($UnlockedMaskSelector.selected_masks[0]))
	if len(selected_masks) >= 2:
		$RightMask.texture = load(get_mask_img($UnlockedMaskSelector.selected_masks[1]))
