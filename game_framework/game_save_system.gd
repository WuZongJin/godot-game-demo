extends Node
class_name GameSaveSystem

const CONFIG_FILE := "user://config.cfg"

func load_config() -> ConfigFile:
	var cfg = ConfigFile.new()
	var unexistant = cfg.load(CONFIG_FILE) #Checks if the config file exists;
	if unexistant: 
		revert_config(cfg)
		#This function will be recalled by revert_config so let's end it;
		return cfg
	return cfg

func revert_config(cfg: ConfigFile):
	#Write default settings to cfg;
	for key in UserData.default_config.keys():
		cfg.set_value("settings", key, UserData.default_config[str(key)])
	cfg.save(CONFIG_FILE)
	load_config()
	return cfg

func save_config(setting: String, value):
	var cfg = ConfigFile.new()
	var unexistant = cfg.load(CONFIG_FILE)
	#Check if the file went away during runtime;
	if unexistant: cfg = revert_config(cfg)
	cfg.set_value("settings", setting, value)
	cfg.save(CONFIG_FILE)


func save_all_config():
	var cfg = ConfigFile.new()
	var unexistant = cfg.load(CONFIG_FILE)
	#Check if the file went away during runtime;
	if unexistant: cfg = revert_config(cfg)
	var data = UserData.save_config()
	for key in data.keys():
		cfg.set_value("settings", key, data[str(key)])
	cfg.save(CONFIG_FILE)
	
	
