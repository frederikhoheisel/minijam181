extends Node2D

@export var strength1 : float = 0.015
@export var strength2 : float = 0.008



func _process(_delta : float) -> void:
	adjustShadow(1, sin(Time.get_ticks_msec()) * strength1)
	adjustShadow(2, sin(Time.get_ticks_msec() + 100) * strength2)
	pass

func adjustShadow(ringNr : int, strength : float) -> void:
	var shadowSprite : Sprite2D = get_node("Shadow")
	var gradientTexture : GradientTexture2D = shadowSprite.texture
	var gradientShadow : Gradient = gradientTexture.gradient
	
	gradientShadow.set_offset(ringNr, lerp(gradientShadow.get_offset(ringNr), gradientShadow.get_offset(ringNr) + strength, 0.5))
	

func _on_entrance_2d_body_entered(_body: Node2D) -> void:
	if $"Entrance2D".get_overlapping_bodies().size() > 1:
		return

	var lightningAmount : int = 2
	for i : int in lightningAmount:
		startThunder()

	


func startThunder() -> void:
	if $"Entrance2D".get_overlapping_bodies().size() == 0:
		return

	var spawnPoint : Vector2 = calculateSpawnPoint()

	spawnStatic(spawnPoint)

	await get_tree().create_timer(0.3).timeout

	spawnLightning(spawnPoint)

	startThunder()


func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()


# Show Static Animation at random point in Shadow
func spawnStatic(spawnPoint : Vector2) -> void:
	$StaticAnimation.position = spawnPoint
	$StaticAnimation.visible = true

#Strike Lightning at point
func spawnLightning(spawnPoint : Vector2) -> void:
	$LightningAnimation.position = spawnPoint
	$LightningAnimation.position.y -= 220
	$"LightningAnimation".frame = 0
	$"LightningAnimation".play()
	$LightningAnimation/DeathZone/CollisionShape2D.set_deferred("disabled", false);
	await get_tree().create_timer(0.1).timeout
	$LightningAnimation/DeathZone/CollisionShape2D.set_deferred("disabled", true);


func calculateSpawnPoint() -> Vector2:
	var angle : float = randf() * TAU
	var r : float = sqrt(randf())
	var x : float = r * cos(angle) * $Shadow.scale.x * $Shadow.texture.width / 2
	var y : float = r * sin(angle) * $Shadow.scale.y * $Shadow.texture.height / 2

	var spawnPoint : Vector2 = $Shadow.position + Vector2(x, y)
	return spawnPoint
