extends Area2D

var eggId : int = -1

func _ready() -> void:
	
	pass

func _on_body_entered(body:Node2D) -> void:
	$EntityAudioPlayer.play()
	$EntityAudioPlayer.reparent.call_deferred(get_parent().get_parent())
	SignalBus.egg_found.emit(eggId)
	get_parent().queue_free()
