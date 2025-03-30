extends Sprite2D

@export var eggId : int = -1
@onready var child : Area2D = $Area2D

func _ready() -> void:
	if child:
		child.eggId = eggId
	pass
