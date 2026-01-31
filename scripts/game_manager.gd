extends Node

const MAIN_SCENE = preload("res://scenes/game_manager.tscn")
const AMOUNT_CHARACTERS = 4
const CHARACTER_PATH = 'res://assets/characters/c'
const SPRITE_FRAMES_PATH = 'res://assets/sprite-frames/sp'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hud/MaskSelector.render_masks([{"maskId": 1, "imagePath": "res://assets/masks/m1.png"}, {"maskId": 2, "imagePath": "res://assets/masks/m2.png"}])
	choose_characters() #chooses and assigns to the childs
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func choose_characters():
	var n = int(randf() * AMOUNT_CHARACTERS) #number of polaroid
	$Polaroid.texture_path = CHARACTER_PATH + str(n)  + '.png'
	print("Chosen polaroid: ", n)
	var n_char = randf()  #number of character
	print("Right?: ", n_char < 0.3)
	if n_char < 0.3: 
		$Character.frame_path = SPRITE_FRAMES_PATH + str(n) + '.tres'
	else:
		n_char = int(randf() * AMOUNT_CHARACTERS) #small chances that the new character is the correct one
		$Character.frame_path = SPRITE_FRAMES_PATH + str(n_char)
		print("Wrong character: ", n_char)
	$Polaroid.set_sprite()
	$Character.set_sprite()
		
		
		
		
