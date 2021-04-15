extends Node

enum BUS {MASTER, MUSIC, SFX}

var volume_master: float = 1.0
var volume_music: float = 1.0
var volume_sfx: float = 1.0
var window_size = Vector2(1024, 600)
var is_fullscreen = false

var default_config: Dictionary = {
	"volume_master": 1.0,
	"volume_music": 1.0,
	"volume_sfx": 1.0,
	"window_size": Vector2(1024, 600),
	"is_fullscreen": false,
}

func _ready():
	var cfg = GameManager.load_config();
	volume_master = cfg.get_value("settings", "volume_master", 1.0)
	volume_music = cfg.get_value("settings", "volume_music", 1.0)
	volume_sfx = cfg.get_value("settings", "volume_sfx", 1.0)
	window_size = cfg.get_value("settings", "window_size", Vector2(1024, 600))
	is_fullscreen = cfg.get_value("settings", "is_fullscreen", false)
	apply_game_config()
	
func apply_game_config():
	set_audio(BUS.MASTER, volume_master)
	set_audio(BUS.MUSIC, volume_music)
	set_audio(BUS.SFX, volume_sfx)
	OS.set_window_size(window_size)
	OS.set_window_fullscreen(is_fullscreen)
	OS.center_window()

func set_audio(bus, value):
	AudioServer.set_bus_volume_db(bus, linear2db(value))

func save_config() -> Dictionary:
	var data = {
		"volume_master": volume_master,
		"volume_music": volume_music,
		"volume_sfx": volume_sfx,
		"window_size": window_size,
		"is_fullscreen": is_fullscreen,
	}
	return data

func set_volume_matser(value):
	volume_master = value
	set_audio(BUS.MASTER, volume_master)
	
func set_volume_music(value):
	volume_music = value
	set_audio(BUS.MUSIC, volume_music)

func set_volume_sfx(value):
	volume_sfx = value
	set_audio(BUS.SFX, volume_sfx)

func set_window_size(value):
	window_size = value
	OS.set_window_size(window_size)
	OS.center_window()

func set_is_fullscreen(value):
	is_fullscreen = value
	OS.set_window_fullscreen(is_fullscreen)
