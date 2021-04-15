extends Node

var game_save_system: GameSaveSystem

var main: Main

func _init():
	game_save_system = GameSaveSystem.new()
	pass

func _ready():
	pass

func set_main(_main: Main):
	if main: 
		return
	main = _main
	SceneManager.main = main
	
func load_config() -> ConfigFile:
	 return game_save_system.load_config()
