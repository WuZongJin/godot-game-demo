extends BaseTable
class_name ItemTable

var item_data = {}

func _init().("item.json"):
	var key_data = self.table_data.keys
	for row in self.table_data.rows:
		var row_data = self.table_data.rows[row]
		item_data[row_data[key_data["id"]]] = row_data[key_data["name"]]
	pass
