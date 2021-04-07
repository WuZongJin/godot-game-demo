extends Node

func set_normal_btn_behavior(btn: Button, object, func_name: String):
	btn.rect_pivot_offset = btn.rect_size / 2
	btn.connect("button_down", self, "on_btn_down_scale_tween", [btn])
	btn.connect("button_up", self, "on_btn_up_scale_tween", [btn])
	btn.connect("pressed", object, func_name)


func on_btn_down_scale_tween(btn: Button):
	var tween: Tween = null
	for child in btn.get_children():
		if child is Tween:
			tween = child as Tween
			break
	if is_instance_valid(tween):
		tween.reset_all()
		tween.remove_all()
	else:
		tween = Tween.new()
		btn.add_child(tween)
	
	tween.interpolate_property(btn, "rect_scale", Vector2.ONE, Vector2(0.8, 0.8), 0.13, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()


func on_btn_up_scale_tween(btn: Button):
	var tween: Tween = null
	for child in btn.get_children():
		if child is Tween:
			tween = child as Tween
			break
	if is_instance_valid(tween):
		tween.reset_all()
		tween.remove_all()
	else:
		tween = Tween.new()
		btn.add_child(tween)
	
	tween.interpolate_property(btn, "rect_scale", Vector2(0.8, 0.8), Vector2.ONE, 0.13, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0)
	tween.start()
