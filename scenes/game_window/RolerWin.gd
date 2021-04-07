extends Control

var item_grid = []
var data = [10001, 10002]

func _ready():
	_init_item_grid()
	pass

func _init_item_grid():
	for i in range(24):
		var grid = get_node("MarginContainer3/MarginContainer/GridContainer/ItemGrid" + String(i+1))
		item_grid.append(grid)
	var count = 0
	for d in data:
		var item = Item.new(d)
		item_grid[count].set_item(item)
		count += 1
