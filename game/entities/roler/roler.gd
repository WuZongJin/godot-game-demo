extends Node2D

const texture_dir = "res://assert/textures/roler_texture/"
var textures
var texture_index = 0
var animations = ["idle", "walk"]
var anime_index = 0


func _ready():
	textures = _get_bone_texture_in_dir(texture_dir)
	pass # Replace with function body.


func _get_bone_texture_in_dir(path: String, files: Array = []) -> Array:
	var dir = Directory.new()
	if dir.open(path) != OK:
		return files

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if file_name != "." and file_name != "..":
			if dir.current_is_dir():
				_get_bone_texture_in_dir(path + file_name + '/', files)
			else:
				if file_name.find(".import") < 0:
					files.push_back(path + file_name)

		file_name = dir.get_next()
	return files
	
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_down"):
		next_texture()
	if event.is_action_pressed("ui_up"):
		pre_texture()
	if event.is_action_pressed("ui_right"):
		changeAnimation()

func pre_texture():
	if textures.size() <= 0:
		return
	texture_index -= 1
	if texture_index <= 0:
		texture_index = textures.size() - 1
	changeTexture()

func next_texture():
	if textures.size() <= 0:
		return
	texture_index += 1
	if texture_index >= textures.size():
		texture_index = 0
	changeTexture()

func changeTexture():
	var tex_res = load(textures[texture_index])
	$sprite/arm_l.texture = tex_res
	$sprite/arm_l/hand_l.texture = tex_res
	$sprite/leg_r.texture = tex_res
	$sprite/head.texture = tex_res
	$sprite/body.texture = tex_res
	$sprite/arm_r.texture = tex_res
	$sprite/arm_r/hand_r.texture = tex_res
	$sprite/leg_l.texture = tex_res
	$sprite/hair_l.texture = tex_res
	$sprite/hair_r.texture = tex_res


func changeAnimation():
	anime_index += 1
	if anime_index >= animations.size():
		anime_index = 0
	$AnimationPlayer.play(animations[anime_index])
