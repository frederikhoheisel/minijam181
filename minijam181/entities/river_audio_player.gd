extends AudioStreamPlayer2D

@export var horde:Node2D

func _process(delta: float) -> void:
	global_position.x = horde.global_position.x
