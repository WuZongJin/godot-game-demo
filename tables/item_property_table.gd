extends BaseTable
class_name ItemPropertyTable

var property_data = {}

func _init().("item_property.json"):
	var key_data = self.table_data.keys
	for row in self.table_data.rows:
		var row_data = self.table_data.rows[row]
		var data = {}
		for key in key_data:
			data[key] = row_data[key_data[key]]
		property_data[String(row_data[key_data["item_id"]])] = data

func get_property(id):
	return property_data[String(id)]
