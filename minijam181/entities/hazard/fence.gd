extends StaticBody2D

@export var dangerous : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dangerous:
		$Sprite2D.texture.region = Rect2(0, 0, 64, 32)
	else:
		$Sprite2D.texture.region = Rect2(0, 32, 64, 32)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !dangerous:
		return
	if !body.has_meta("IsRabbit"):
		return
	body.die("rain")
