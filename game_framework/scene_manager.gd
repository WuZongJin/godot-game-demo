extends Node

const file_suffix = ".tscn"

var main: Main

var loaded_scenes_map = {}
var loaded_scenes_list: Array = []

var loader = null
var _is_loading_scene = false
var _is_loading_additive = false
var _loading_scene_id = ""
var _scene_load_progress = 0
var _scene_faild_to_load = false

var max_load_time = 100 #ms

func _ready():
	pass

func open_scene(scene_name:String):
	var path = GameTableManager.game_scene_table.get_scene_path(scene_name)
	var scene_path
	if !path or path == "":
		scene_path = GameSetting.scenes_directory + scene_name + file_suffix
	else:
		scene_path = GameSetting.scenes_directory + path + scene_name + file_suffix
	var scene = load(scene_path)
	var new_scene = scene.instance()
	new_scene.name = scene_name
	loaded_scenes_map[scene_name] = new_scene
	loaded_scenes_list.append(new_scene)
	added_scene_to_game(new_scene)


func close_scene(scene_name: String):
	if not loaded_scenes_map.has(scene_name):
		return
	var scene = loaded_scenes_map[scene_name]
	for val in range(loaded_scenes_list.size()):
		if loaded_scenes_list[val] == scene:
			loaded_scenes_list.remove(val)
	loaded_scenes_map.erase(scene_name)
	scene.queue_free()


func change_scene(from_scene, to_scene):
	pass	

func added_scene_to_game(scene, layer = GameLayerConstant.SCENELayer):
	if not main:
		create_default_main()
	match layer:
		GameLayerConstant.DOWNLayer:
			main.down_layer.add_child(scene)
		GameLayerConstant.SCENELayer:
			main.scene_layer.add_child(scene)
		GameLayerConstant.WINDOWLayer:
			main.window_layer.add_child(scene)
		GameLayerConstant.POPUPLayer:
			main.popup_layer.add_child(scene)


func load_scene(scene_name, additive = false):
	var to_load: PackedScene
	to_load = load(scene_name)
	

func add_dialog(dialog):
	if not main:
		create_default_main()
	main.popup_layer.call_deferred("add_child", dialog)

func create_default_main():
	var main_res = load("res://main.tscn")
	var main_ins = main_res.instance()
	main_ins.game_start = false
	get_tree().root.add_child(main_ins)

