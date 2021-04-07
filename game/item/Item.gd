extends Reference
class_name Item

var item_count: int
var item_property:ItemProperty

func _init(id):
	item_property = ItemProperty.new(id)
	

