extends Control 

enum ClickType {
	NULL,
	NORMAL,
	SCALE,
	DARK,
	MOVE,
}

var callback: FuncRef = null
export (ClickType) var click_type
export (float) var scale = 0.9
export (Vector2) var move_distance = Vector2(0, 2)

var tween: Tween
var ori_scale
var ori_position

var pre_click_fineshed = true

func _ready():
	ori_scale = rect_scale
	pass # Replace with function body.

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		match click_type:
			ClickType.NULL:
				pass
			ClickType.NORMAL:
				on_btn_down_normal()
			ClickType.SCALE:
				on_btn_down_scale_tween()
			ClickType.DARK:
				on_btn_down_dark()
			ClickType.MOVE:
				on_btn_down_move()
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and not event.pressed:
		match click_type:
			ClickType.NULL:
				pass
			ClickType.NORMAL:
				on_btn_up_normal()
			ClickType.SCALE:
				on_btn_up_scale_tween()
			ClickType.DARK:
				on_btn_up_dark()
			ClickType.MOVE:
				on_btn_up_move()
		print(rect_position, rect_size , event.position )
		if Rect2(Vector2(0, 0), rect_size).has_point(event.position):
			if callback:
				callback.call_func()

func find_and_reset_tween():
	for child in get_children():
		if child is Tween:
			tween = child as Tween
			break
	if is_instance_valid(tween):
		tween.reset_all()
		tween.remove_all()
	else:
		tween = Tween.new()
		add_child(tween)

#NORMAL
func on_btn_down_normal():
	find_and_reset_tween()
	ori_position = rect_position	
	modulate = Color.gray
	tween.interpolate_property(self, "rect_position", ori_position, ori_position + move_distance, 0.13, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()
	

func on_btn_up_normal():
	find_and_reset_tween()
	modulate = Color.white
	tween.interpolate_property(self, "rect_position", ori_position + move_distance, ori_position , 0.13, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()


#DARK
func on_btn_down_dark():
	modulate = Color.gray

func on_btn_up_dark():
	modulate = Color.white


#MOVE
func on_btn_down_move():
	find_and_reset_tween()
	ori_position = rect_position
	tween.interpolate_property(self, "rect_position", ori_position, ori_position + move_distance, 0.13, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()
	

func on_btn_up_move():
	find_and_reset_tween()
	tween.interpolate_property(self, "rect_position", ori_position + move_distance, ori_position, 0.13, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()


#SCALE
func on_btn_down_scale_tween():
	find_and_reset_tween()
	tween.interpolate_property(self, "rect_scale", ori_scale, ori_scale * scale, 0.13, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()


func on_btn_up_scale_tween():
	find_and_reset_tween()
	
	tween.interpolate_property(self, "rect_scale", ori_scale * scale, ori_scale, 0.13, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()

#func _draw():
#	if GameSetting.is_in_debug:
#		draw_rect( Rect2(Vector2.ZERO, rect_size), Color.red, false, 3)
