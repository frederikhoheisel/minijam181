extends Node

@export
var fruit = preload("res://entities/pickups/pickups.tscn")

var fruit_instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("manager ready")
	spawn_pickups()
	SignalBus.restart.connect(refresh_pickups)

func spawn_pickups():
	print("spawning fruit")
	fruit_instance = fruit.instantiate()
	$"..".add_child.call_deferred(fruit_instance)
	
func delete_pickups():
	fruit_instance.queue_free()
	
func refresh_pickups():
	print("refreshing pickups")
	delete_pickups()
	spawn_pickups()
