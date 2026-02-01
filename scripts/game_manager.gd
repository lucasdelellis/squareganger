extends Node

const MAIN_SCENE = preload("res://scenes/game_manager.tscn")
const GROUP_AMOUNT = 3
const CHARACTERS_AMOUNT = 3
const CHARACTER_PATH = 'res://assets/characters/c'
const MASK_PATH = 'res://assets/masks/m'

var player_masks: Array[int] = GameState.masks

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func start_game() -> void:
	var masks = []
	for mask_id in player_masks:
		masks.append({"maskId": mask_id, "imagePath": get_mask_img(mask_id)})
	
	$Hud/MaskSelector.render_masks(masks)
	$Hud/MaskSelector.mask_selected.connect(_on_mask_selected)
	$Hud/ChooseButtons.accept_pressed.connect(_on_accept_pressed)
	$Hud/ChooseButtons.reject_pressed.connect(_on_reject_pressed)
	
	choose_characters() #chooses and assigns to the childs	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func choose_characters():
	var group = int(randf() * GROUP_AMOUNT) + 1 #number of groups
	var n = int(randf() * CHARACTERS_AMOUNT) + 1 #number of faces
	$Polaroid.texture_path = get_polaroid_img(group, n)
	print("Chosen polaroid: ", n)
	var n_char = randf()  #number of character
	print("Right?: ", n_char < 0.3)
	if n_char < 0.3: 
		$Character.face_path = get_character_img(group, n)
	else:
		n_char = int(randf() * CHARACTERS_AMOUNT) + 1 #small chances that the new character is the correct onee
		$Character.face_path = get_character_img(group, n_char)
		print("Wrong character: ", n_char)
	$Polaroid.set_sprite()
	$Character.set_sprite()

func _on_mask_selected(id: int):
	print(id)
	var mask_path = get_mask_img(id)
	$Character.put_mask_on(mask_path)
	
func get_character_img(group: int, n: int):
	return CHARACTER_PATH + str(group) + str(n) + '.png'

func get_polaroid_img(group: int, n: int):
	return CHARACTER_PATH + str(group) + str(n) + '.png'

func get_mask_img(n: int):
	return MASK_PATH + str(n) + '.png'

func _on_accept_pressed():
	print("accept")
	
func _on_reject_pressed():
	print("reject")
