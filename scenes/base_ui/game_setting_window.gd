extends Control

onready var volume_master_slider = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HSlider
onready var volume_music_slider = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HSlider2
onready var volume_sfx_slider = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HSlider3

onready var volume_master_label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Label2
onready var volume_music_label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Label3
onready var volume_sfx_label = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Label4

var window_size = [
	Vector2(1024, 600),
	Vector2(1920, 1080),
]

func _ready():
	_init_ui_component()
	pass # Replace with function body.

func _init_ui_component():
	volume_master_slider.value = UserData.volume_master * 100
	volume_music_slider.value = UserData.volume_music * 100
	volume_sfx_slider.value = UserData.volume_sfx * 100
	
	volume_master_label.text = String(UserData.volume_master * 100)
	volume_music_label.text = String(UserData.volume_music * 100)
	volume_sfx_label.text = String(UserData.volume_sfx * 100)
	



func _on_HSlider_value_changed(value):
	UserData.set_volume_matser(value / 100)
	volume_master_label.text = String(UserData.volume_master * 100)
	pass # Replace with function body.


func _on_HSlider2_value_changed(value):
	UserData.set_volume_music(value / 100)
	volume_music_label.text = String(UserData.volume_music * 100)
	pass # Replace with function body.


func _on_HSlider3_value_changed(value):
	UserData.set_volume_sfx(value / 100)
	volume_sfx_label.text = String(UserData.volume_sfx * 100)
	pass # Replace with function body.


func _on_OptionButton_item_selected(index):
	UserData.set_window_size(window_size[index])
	pass # Replace with function body.


func _on_CheckButton_toggled(button_pressed):
	UserData.set_is_fullscreen(button_pressed)
	pass # Replace with function body.
	

func _on_Button_pressed():
	GameManager.game_save_system.save_all_config()
	pass # Replace with function body.
