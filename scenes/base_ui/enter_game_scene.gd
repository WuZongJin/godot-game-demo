extends Control

onready var bg = $Bg
onready var icon = $GodotIcon
onready var studio = $Studio

var _animation: AnimaNode

func _ready():
	_animation = Anima.begin(self, "ui_anima")
	_animation.then({node = bg, property = 'color', from = bg.color, to = Color(0,0,0,1), duration = 1, delay = 1})
	_animation.then({node = icon, animation = 'bouncing_in_left', duration = 1})
	_animation.then({node = studio, animation = 'bouncing_in_right', duration = 1})
	_animation.set_visibility_strategy(Anima.VISIBILITY.TRANSPARENT_ONLY)
	_animation.then({node = self, property = "modulate", from = self.modulate, to = Color(0,0,0,0), duration = 1, delay = 2, on_completed = [funcref(self, "_change_to_game_title")]})
	_animation.play()
	pass # Replace with function body.

func _change_to_game_title():
	SceneManager.close_scene("enter_game_scene")
	SceneManager.open_scene("game_title_scene");
	pass

func _ui_animation():
	pass
