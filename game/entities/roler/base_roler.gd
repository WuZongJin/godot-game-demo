extends Reference
class_name BaseRoler

#1力量/魔法
#2生命
#3暴击/暴伤
#4移动速度/攻击速度
#5闪避
#6物理防御/魔法防御
#7攻击距离/攻击方式（范围）
#8经验值
#9等级
class Damage:
	var min_damage
	var max_damage

#基础属性
var _health_point: int setget set_health, get_health			#生命值
var _mana_point: int setget set_mana, get_mana				#法力值
var _magic: int setget set_magic, get_magic					#魔法值
var _power: int setget set_power, get_power					#力量
var _agility: int setget set_agility, get_agility				#敏捷
var _defense: int setget set_defense, get_defense				#防御

#游戏数值
var _damage: Damage setget set_damage, get_damage			#伤害范围
var _crit: float setget set_crit, get_crit					#暴击率
var _hit_rate: float setget set_hit_rate, get_hit_rate		#命中率
var _flee: float setget set_flee, get_flee					#闪避值
var exp_point: int 											#经验值
var next_level_point: int									#下一等级所需经验值
var level: int												#等级



#属性的SetGet
func set_health(value):
	_health_point = value

func get_health():
	return _health_point
	
func set_mana(value):
	_mana_point = value

func get_mana():
	return _mana_point

func set_magic(value):
	_magic = value
	
func get_magic():
	return _magic
	
func set_power(value):
	return _power

func get_power():
	return _power

func set_agility(value):
	_agility = value

func get_agility():
	return _agility

func set_defense(value):
	_defense = value

func get_defense():
	return _defense
	
#游戏数值的SetGet
func set_damage(value):
	_damage = value

func get_damage():
	return _damage
	
func set_crit(value):
	_crit = value

func get_crit():
	return _crit
	
func set_hit_rate(value):
	_hit_rate = value

func get_hit_rate():
	return _hit_rate

func set_flee(value):
	_flee = value
	
func get_flee():
	return _flee

func _init():
	pass


