extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng : int = randi_range(0, 9)
	$Sprite2D.texture.region = Rect2(rng * 8, 0, 8, 8)
