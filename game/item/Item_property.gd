extends Reference
class_name ItemProperty

var item_id: int
var item_name: String
var item_desc: String
var item_texture: String
var item_type: int
var item_effect_desc = []

func _init(id):
	var property = GameTableManager.item_property_table.get_property(id)
	item_id = property.item_id
	item_name = property.item_name
	item_desc = property.item_desc
	item_texture = GameSetting.item_texture_directory + property.item_texture + ".tres"
	item_type = property.item_type
	
	
