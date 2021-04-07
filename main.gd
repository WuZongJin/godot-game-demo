extends Node
class_name Main

onready var down_layer = $DownLayer
onready var scene_layer = $SceneLayer
onready var window_layer = $WindowLayer
onready var popup_layer = $PopUpLayer

func _ready():
	GameManager.set_main(self)
	SceneManager.open_scene("enter_game_scene")
