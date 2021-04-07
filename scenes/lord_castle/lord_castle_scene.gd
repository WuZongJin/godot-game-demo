extends Node2D

onready var player = $Player
var tmp  = true
func _ready():
	player.play("walk_back")
	player.animation.seek(0, true)
	player.animation.stop(true)
	player.hide()
	
	
	
	pass 

func _physics_process(delta):
	if tmp:
		var new_dialog = Dialogic.start("timeline-1617795368")
		new_dialog.connect("dialogic_signal", self, "signal_form_dialogic")
		SceneManager.add_dialog(new_dialog)
		tmp = false

func signal_form_dialogic(value):
	if value == "player_show":
		player.show()
