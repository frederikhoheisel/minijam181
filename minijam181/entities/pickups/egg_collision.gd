extends Area2D

var eggId : int = -1

func _ready() -> void:
	
	pass

func _on_body_entered(body:Node2D) -> void:
	SignalBus.egg_found.emit(eggId)
	get_parent().queue_free()
	pass # Replace with function body.
