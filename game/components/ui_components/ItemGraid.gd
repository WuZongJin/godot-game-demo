extends Control
class_name ItemObject

const itemres = preload("res://game/item/Item.gd")

var item: Item

signal right_mouse_clicked
signal double_clicked
signal item_changed(new_item)

var _has_clicked = false
var _click_timer: Timer
const _double_click_time = 0.4
const _show_property_delay = 0.5

func _ready():
	connect("mouse_entered", self, "show_item_property")
	connect("mouse_exited", self, "hide_item_property")
	connect("right_mouse_clicked", self, "on_right_mouse_click")
	connect("double_clicked", self, "on_double_clicked")
	connect("focus_exited", self, "on_focus_exited")
	connect("item_changed", self, "on_item_changed")
	
func _gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_RIGHT:
			emit_signal("right_mouse_clicked")
		elif event.is_pressed() and not _has_clicked and event.button_index == BUTTON_LEFT:
			_has_clicked = true;
			_start_click_timer()
		elif event.is_pressed() and _has_clicked and event.button_index == BUTTON_LEFT:
			_has_clicked = false
			_reset_click_timer()
			emit_signal("double_clicked")


func set_item(_item):
	item = _item
	emit_signal("item_changed", _item)

#Add Timer
func add_timer(name: String, time: float, func_name: String) -> Timer:
	del_timer(name)
	var timer := Timer.new()
	add_child(timer)
	timer.set_name(name)
	timer.set_one_shot(true)
	timer.start(time)
	timer.connect("timeout",self, func_name)
	return timer

func del_timer(name: String) -> void:
	if has_node(name):
		get_node(name).stop()
		get_node(name).queue_free()
		get_node(name).set_name("to_delete")

#Click
func _init_click_timer():
	add_timer("__click_timer__", _double_click_time, "_click_time_out")

func _reset_click_timer():
	del_timer("__click_timer__")

func _start_click_timer():
	_init_click_timer()
	
func _click_time_out():
	del_timer("__click_timer__")
	_has_clicked = false;

#show panel
func _init_show_property_timer():
	add_timer("__show_property__", _show_property_delay, "_show_property_panel")

func _show_property_panel():
	del_timer("__show_property__")
	pass
	
#Signal
func on_item_changed(new_item):
	print("item changed", new_item.item_property.item_id)
	get_node("Item").texture = load(new_item.item_property.item_texture)
	

func show_item_property():
	_init_show_property_timer()
	pass

func hide_item_property():
	print("hide_item")
	pass
	
func on_double_clicked():
	print("double_click")
	pass

func on_right_mouse_click():
	print("right_click")
	pass

func on_focus_exited():
	print("lose_focus")
	pass
	


