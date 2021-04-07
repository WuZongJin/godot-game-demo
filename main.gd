extends Node
class_name Main

onready var down_layer = $DownLayer
onready var scene_layer = $SceneLayer
onready var window_layer = $WindowLayer
onready var popup_layer = $PopUpLayer

var game_start = true

func _ready():
	GameManager.set_main(self)
	if game_start:
		SceneManager.open_scene("enter_game_scene")
