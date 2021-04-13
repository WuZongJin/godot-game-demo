extends Node

var game_scene_table: GameScenesTable
var item_table: ItemTable

func _ready():
	game_scene_table = GameScenesTable.new()
	item_table = ItemTable.new()
