extends TextureRect

const MENU_SCENE = "res://scenes/menu.tscn"
const PATH = "res://assets/tutorial/tut"

var seq: Array[int] = [0,1,2,3]
var act = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = load(PATH + str(0) + ".png")

func _on_left_arrow_pressed() -> void:
	print(act)
	if act == 0:
		print("menu")
		get_tree().change_scene_to_file(MENU_SCENE)
	else:
		act -=1
		texture = load(PATH + str(act) + ".png")

func _on_right_arrow_pressed() -> void:
	print(act)
	if act == 3:
		print("menu")
		get_tree().change_scene_to_file(MENU_SCENE)	
	else:
		act +=1
		texture = load(PATH + str(act) + ".png")
