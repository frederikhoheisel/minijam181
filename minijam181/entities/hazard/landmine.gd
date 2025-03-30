extends Node2D
@export var explosion_radius : int = 32
@export var timer_time : float = 1.0
var count = 0
func _ready() -> void:
	$Krater.hide()
	$Sprite2D.hide()
	$AnimatedSprite2D.hide()
	$PointLight2D.hide()
	$ExplosionArea/CollisionShape2D.shape.radius = explosion_radius
	$Timer.wait_time = timer_time
	$ExplosionArea/CollisionShape2D.disabled = true

func _process(_delta : float) -> void:
	pass
	

func _on_trigger_area_body_entered(body: Node2D) -> void:
	print(body)
	if !body.has_meta("IsRabbit"):
		return
	print("trigggerd")
	if $Timer.is_stopped():
		$Sprite2D.show()
		$Timer.start()
		$TriggerArea/CollisionShape2D.set_deferred("disabled", true)
	

func _on_timer_timeout() -> void:
	$EntityAudioPlayer.play()
	print("explode")
	$PointLight2D.show()
	$ExplosionArea/CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.hide()
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("explosion")
	$Krater.show()
	$Krater.z_index = -1
	await get_tree().create_timer(0.1).timeout
	$PointLight2D.hide()
	$ExplosionArea/CollisionShape2D.set_deferred("disabled", true)


func _on_explosion_area_body_entered(body: Node2D) -> void:
	count += 1
	print("sdlfghjkasödlfgkj: ", count)
	if body.has_meta("IsRabbit"):
		print(body.name)
		#print("landmine: " + str(body.global_position))
		body.die("landmine")
