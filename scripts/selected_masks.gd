extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Mask1.texture = load("res://assets/masks/m1.png")
	$Mask2.texture = load("res://assets/masks/m2.png")
	#set_masks()

func set_mask(n: int):
	pass
	
func eliminate_mask(n: int):
	pass
	
