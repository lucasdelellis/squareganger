extends Node

const MAIN_SCENE = preload("res://scenes/game_manager.tscn")
const RESTART_SCENE = preload("res://scenes/restart_menu.tscn")
const GROUP_AMOUNT = 3
const CHARACTERS_AMOUNT = 3
const MASKS_AMOUNT = 5
const CHARACTER_PATH = 'res://assets/characters/c'
const POLAROID_PATH = 'res://assets/polaroids/c'
const MASK_PATH = 'res://assets/masks/m'

# Array with current masks
var player_masks: Array[int] = GameState.masks
var right_character
var random_character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func start_game() -> void:
	render_masks()
	$Hud/MaskSelector.mask_selected.connect(_on_mask_selected)
	$Hud/ChooseButtons.accept_pressed.connect(_on_accept_pressed)
	$Hud/ChooseButtons.reject_pressed.connect(_on_reject_pressed)
	
	choose_characters() #chooses and assigns to the childs
	
func choose_characters():
	var group = int(randf() * GROUP_AMOUNT) + 1 #number of groups
	var n = int(randf() * CHARACTERS_AMOUNT) + 1 #number of faces
	right_character = str(group) + str(n)
	$Polaroid.texture_path = get_polaroid_img(group, n)
	print("Chosen polaroid: ", group, " ", n)
	var prob_same_char = randf()  #probability of being the same character
	random_character = str(group)

	if prob_same_char > 0.3:
		n = int(randf() * CHARACTERS_AMOUNT) + 1 #small chances that the new character is the correct onee	 

	$Character.face_path = get_character_img(group, n)
	random_character += str(n)
	print("Chosen character: ", group, " ", n)
	print(right_character, " ", random_character, " ", right_character == random_character)
	$Polaroid.set_sprite()
	$Character.set_sprite()

func _on_mask_selected(id: int):
	print(id)
	var mask_path = get_mask_img(id)
	$Character.put_mask_on(mask_path)
	
func get_character_img(group: int, n: int):
	return CHARACTER_PATH + str(group) + str(n) + '.png'

func get_polaroid_img(group: int, n: int):
	return POLAROID_PATH + str(group) + str(n) + '.png'

func get_mask_img(n: int):
	return MASK_PATH + str(n) + '.png'

func _on_accept_pressed():
	if right_character == random_character:
		print("Correct guess")
		right_guess()	
	else:
		wrong_guess()
	
func _on_reject_pressed():
	if right_character != random_character:
		print("Correct guess")
		right_guess()
	else:
		wrong_guess()
		
func right_guess():
	GameState.score += 1000
	$Hud/Score.text = str(GameState.score)
	check_mask_unlocking()
	choose_characters()
	$Character.put_mask_on(MASK_PATH+'0.png')
	print(GameState.score)
	
func wrong_guess():
	print("Wrong guess")
	get_tree().change_scene_to_packed(RESTART_SCENE)
	
func check_mask_unlocking():
	# TODO: Check unlocking criteria
	if GameState.score % 3000 == 0:
		var found = len(GameState.obtained_masks) >= MASKS_AMOUNT
		var new_mask
		while not found:
			new_mask = int(randf() * MASKS_AMOUNT) + 1
			found = not GameState.obtained_masks.has(new_mask)
		GameState.obtained_masks.append(new_mask)
		player_masks.append(new_mask)
		render_masks()
		
func render_masks():
	var masks = []
	for mask_id in player_masks:
		masks.append({"maskId": mask_id, "imagePath": get_mask_img(mask_id)})
	
	$Hud/MaskSelector.render_masks(masks)
