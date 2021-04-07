tool
extends Control

enum ColorType{
	RED,
	BLUE,
	GREEN,
	YELLOW,
}

onready var bar = $BarValue/Bar
onready var value_label = $ValueLabel
onready var property_label = $PropertyName

export (int) var cur_value: int
export (int) var max_value: int
export (String) var property_name

export (ColorType) var colorType
# Called when the node enters the scene tree for the first time.
func _ready():
	property_label.text = property_name
	match colorType:
		ColorType.RED:
			bar.texture = load("res://assert/alta_resource/ui_texture/ui.sprites/ui_bar_value_darkred.tres")
		ColorType.BLUE:
			bar.texture = load("res://assert/alta_resource/ui_texture/ui.sprites/ui_bar_value_blue.tres")
		ColorType.GREEN:
			bar.texture = load("res://assert/alta_resource/ui_texture/ui.sprites/ui_bar_value_drakgreen.tres")
		ColorType.YELLOW:
			bar.texture = load("res://assert/alta_resource/ui_texture/ui.sprites/ui_bar_value_yellow.tres")
	update_progress_bar()
	pass 

func init(_cur,  _max):
	cur_value = _cur
	max_value = _max
	update_progress_bar()

func set_value(_cur,  _max):
	cur_value = _cur
	max_value = _max
	update_progress_bar()

func update_progress_bar():
	value_label.text = String(cur_value) + "/" + String(max_value)
	bar.rect_size.x = 100 * cur_value / max_value
