extends Resource
class_name BaseTable

var table_data = null
var table_file_path = null

func _init(table_name: String):
	table_file_path = GameSetting.table_directory + table_name
	table_data = _load_json()

func _load_json() -> Dictionary:
	var file: File = File.new()
	if file.open(table_file_path, File.READ) != OK:
		file.close()
		return {'error': 'file read error'}
	var data_text: String = file.get_as_text()
	file.close()
	var data_parse: JSONParseResult = JSON.parse(data_text)
	if data_parse.error != OK:
		return {'error': 'data parse error'}
	return data_parse.result
