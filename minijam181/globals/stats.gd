extends Node

var current_horde_size: int = 0

var total_deaths: int = 0
var mine_deaths: int = 0
var hunter_deaths: int = 0
var zap_deaths: int = 0
var drown_deaths: int = 0
var bird_deaths: int = 0

var eggs_found: int = 0

func _ready() -> void:
	SignalBus.rabbit_died.connect(_on_rabbit_died)
	

func _on_rabbit_died(rabbit: RigidBody2D, death_type: String, pos: Vector2) -> void:
	total_deaths +=1
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
