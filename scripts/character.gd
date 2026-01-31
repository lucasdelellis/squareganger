extends Node2D

@export var frame_path: String

func _ready() -> void:
	show()
	put_mask_on("res://assets/masks/m0.png")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func put_mask_on (mask_path: String): #Changes masks
	$Mask.texture = load(mask_path)
	
func take_mask_off(): #When the player guesses right or wrong for the second time
	$Maks.fade_out()
	#TO DO: add a timer for the fade_out
	$Mask.hide()

func set_sprite():
	if frame_path:
		$AnimatedSprite2D.sprite_frames = load(frame_path)
		$AnimatedSprite2D.play()
	
