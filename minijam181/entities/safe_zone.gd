extends Area2D



func _on_body_exited(_body:Node2D) -> void:
    SignalBus.in_safe_zone.emit(false)

func _on_body_entered(_body:Node2D) -> void:
        SignalBus.in_safe_zone.emit(true)

