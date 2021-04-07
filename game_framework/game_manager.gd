extends Node

var main: Main
func _ready():
	pass

func set_main(_main: Main):
	if main: 
		return
	main = _main
	SceneManager.main = main
	

