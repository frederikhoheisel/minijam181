extends Node

var current_horde_size: int = 0:
	set(value):
		current_horde_size = value
		# if current_horde_size <= 0:
		# 	print("stats, horde leer")
		#	SignalBus.restart.emit()

	

var total_deaths: int = 0
var mine_deaths: int = 0
var hunter_deaths: int = 0
var zap_deaths: int = 0
var drown_deaths: int = 0
var bird_deaths: int = 0

var rasenmäher_deaths: int = 0

var eggs_found: int = 0

var specific_egg_found : Array[int]

func _ready() -> void:
	specific_egg_found.resize(5)
	SignalBus.rabbit_died.connect(_on_rabbit_died)
	SignalBus.egg_found.connect(_on_egg_found)
	
func _on_rabbit_died(rabbit: RigidBody2D, death_type: String, pos: Vector2) -> void:
	total_deaths +=1
	current_horde_size -= 1
	match death_type:
		"headshot": 
			hunter_deaths += 1
		"landmine":
			mine_deaths += 1
		"rain":
			zap_deaths += 1
		"river":
			drown_deaths += 1
		"default": 
			return

func _on_egg_found(eggId : int) -> void:
	eggs_found += 1
	if eggId == -1:
		return
	specific_egg_found[eggId] = 1

func get_found_eggs() -> PackedByteArray:
	return specific_egg_found
