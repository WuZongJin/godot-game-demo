extends BaseTable
class_name GameScenesTable

var scene_path_data = {}

func _init().("game_scenes.json"):
	var key_data = self.table_data.keys
	for row in self.table_data.rows:
		var row_data = self.table_data.rows[row]
		scene_path_data[row_data[key_data["scene_name"]]] = row_data[key_data["scene_path"]]

func get_table_data():
	return self.table_data

func get_scene_path(scene_name):
	if scene_path_data.has(scene_name):
		return scene_path_data[scene_name]
	return null
