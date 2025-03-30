extends StaticBody2D

func _ready() -> void:
	var i: int = randi_range(0, 3)
	match i:
		0:
			$Sprite2D.texture.region = Rect2(32, 0, 32, 64)
		1:
			$Sprite2D.texture.region = Rect2(64, 0, 32, 64)
		2:
			$Sprite2D.texture.region = Rect2(96, 0, 32, 64)
		3:
			$Sprite2D.texture.region = Rect2(0, 64, 32, 64)
