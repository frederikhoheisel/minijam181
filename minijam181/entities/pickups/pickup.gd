extends Area2D

var frames


func _ready() -> void:
	var index: int = randi_range(0, 2)
	match index:
		0:
			$Sprite2D.region_rect.position.x = 16
			$Sprite2D.region_rect.position.y = 0
		1:
			$Sprite2D.region_rect.position.x = 0
			$Sprite2D.region_rect.position.y = 16
		2:
			$Sprite2D.region_rect.position.x = 16
			$Sprite2D.region_rect.position.y = 16

func _process(_delta: float) -> void:
	pass

#Liebe
func _on_body_entered(_body: Node2D) -> void:
	SignalBus.fruit_eaten.emit()
	print("pickup eaten")
	queue_free()
