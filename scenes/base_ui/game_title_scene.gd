extends Control

onready var start_btn = $GameUI/StartButton
onready var load_btn = $GameUI/LoadButton
onready var exit_btn = $GameUI/ExitButton
onready var title = $GameUI/Title
export (int) var speed = 100

func _ready():
	_init_ui_component()
	_ui_animation()
	pass # Replace with function body.

func _init_ui_component():
	start_btn.callback = funcref(self, "_on_start_btn_press")
	load_btn.callback = funcref(self, "_on_load_btn_press")
	exit_btn.callback = funcref(self, "_on_exit_btn_press")
	pass
	
func _ui_animation():
	var anima = Anima.begin(self)
	anima.with({ node = start_btn, animation = "fade_in_left_big", duration = 1, delay = 0.5})
	anima.with({ node = load_btn, animation = "fade_in_left_big", duration = 1, delay = 0.75})
	anima.with({ node = exit_btn, animation = "fade_in_left_big", duration = 1, delay = 1})
	anima.then({node = title, animation = "fade_in_down_big", duration = 1, delay = 1.4})
	anima.set_visibility_strategy(Anima.VISIBILITY.TRANSPARENT_ONLY)
	anima.play()

func _on_start_btn_press():
	print("sssss")
	pass

func _on_load_btn_press():
	print("sssdddss")
	pass

func _on_exit_btn_press():
	print("ssssaaas")
	pass
	
func _process(delta):
	$Ground1.position.x -= speed * delta
	$Ground2.position.x -= speed * delta
	
	$Back.position.x -= speed * 0.7 * delta
	$Back2.position.x -= speed * 0.7 * delta
	if $Ground1.position.x <= -1024:
		$Ground1.position.x = 1024
	if $Ground2.position.x <= -1024:
		$Ground2.position.x = 1024
	if $Back.position.x <= -1024:
		$Back.position.x = 1024
	if $Back2.position.x <= -1024:
		$Back2.position.x = 1024
	
func _ground1_restart():
	$Ground1.position.x = 1024

func _ground2_restart():
	$Ground2.position.x = -1024
