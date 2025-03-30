extends Node2D
@export var explosion_radius : int = 32
@export var timer_time : float = 1.0

func _ready() -> void:
	$Sprite2D.hide()
	$ExplosionArea/CollisionShape2D.shape.radius = explosion_radius
	$Timer.wait_time = timer_time
	$ExplosionArea/CollisionShape2D.disabled = true
func _process(_delta) -> void:
	pass
	


func _on_trigger_area_body_entered(_body: Node2D) -> void:
	print("trigggerd")
	if $Timer.is_stopped():
		$Sprite2D.show()
		$Timer.start()
		$TriggerArea/CollisionShape2D.set_deferred("disabled", true)
	

func _on_timer_timeout() -> void:
	print("explode")
	$ExplosionArea/CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.hide()
	await get_tree().create_timer(0.1).timeout
	$ExplosionArea/CollisionShape2D.set_deferred("disabled", true)


func _on_explosion_area_body_entered(body: Node2D) -> void:
	if body.has_meta("IsRabbit"):
		body.die("landmine")
