extends Node2D

var player_anima1_completed = false
var player_anima2_completed = false
var player_anima3_completed = false

onready var player = $Room/Player
var ori_pos_x
func _ready():
	ori_pos_x = player.position.x
	pass # Replace with function body.


func play_player_anima1():
	while player.position.x > ori_pos_x - 50:
		player.position.x -= 0.5
		if player.animation.current_animation != "walk_left" and not player.animation.is_playing():
			player.animation.play("walk_left")
		yield()
	player.animation.seek(0, true)
	player.animation.stop(true)
	player_anima1_completed = true
	var new_dialog = Dialogic.start("timeline-1617615338")
	new_dialog.connect("dialogic_signal", self, "signal_form_dialogic")
	SceneManager.add_dialog(new_dialog)
	
func _physics_process(delta):
	if not player_anima1_completed:
		play_player_anima1()


func signal_form_dialogic(value):
	if value == "show_summon":
		print("magic_anima");
	if value == "play_summon_player_animation":
		print("play_summon_player_animation")
	if value == "close_win":
		change_to_tower()
		print("close")
		
func change_to_tower():
	SceneManager.close_scene("player_home")
	SceneManager.open_scene("lord_castle_scene")
		
