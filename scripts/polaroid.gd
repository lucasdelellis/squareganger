extends Node2D

@export var texture_path: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_sprite():
	if texture_path:
		print(texture_path)
		$Sprite2D.texture = load(texture_path)
			
