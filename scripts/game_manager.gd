extends Node

const MAIN_SCENE = preload("res://scenes/game_manager.tscn")
const AMOUNT_CHARACTERS = 4
const CHARACTER_PATH = 'res://assets/characters/c'
const SPRITE_FRAMES_PATH = 'res://assets/sprite-frames/sp'
const MASK_PATH = 'res://assets/masks/m'

var player_masks: Array[int] = [1, 2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func start_game() -> void:
	var masks = []
	for mask_id in player_masks:
		masks.append({"maskId": mask_id, "imagePath": get_mask_img(mask_id)})
	$Hud/MaskSelector.render_masks(masks)
	$Hud/MaskSelector.mask_selected.connect(_on_mask_selected)
	choose_characters() #chooses and assigns to the childs	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func choose_characters():
	var n = int(randf() * AMOUNT_CHARACTERS) #number of polaroid
	$Polaroid.texture_path = get_polaroid_img(n)
	print("Chosen polaroid: ", n)
	var n_char = randf()  #number of character
	print("Right?: ", n_char < 0.3)
	if n_char < 0.3: 
		$Character.frame_path = get_character_sf(n)
	else:
		n_char = int(randf() * AMOUNT_CHARACTERS) #small chances that the new character is the correct one
		$Character.frame_path = get_character_sf(n_char)
		print("Wrong character: ", n_char)
	$Polaroid.set_sprite()
	$Character.set_sprite()
				
func _on_mask_selected(id: int):
	print(id)
	var mask_path = get_mask_img(id)
	$Character.put_mask_on(mask_path)
	
func get_character_sf(n: int):
	return SPRITE_FRAMES_PATH + str(n) + '.tres'

func get_polaroid_img(n: int):
	return CHARACTER_PATH + str(n)  + '.png'

func get_mask_img(n: int):
	return MASK_PATH + str(n) + '.png'
