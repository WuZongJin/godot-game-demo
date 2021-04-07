extends Node

var game_scene_table: GameScenesTable
var item_property_table: ItemPropertyTable

func _ready():
	game_scene_table = GameScenesTable.new()
	item_property_table = ItemPropertyTable.new()
