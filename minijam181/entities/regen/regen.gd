extends Area2D

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
	
func playStacAnim(_body : Node2D) -> void:
	print("BZZZZ")
	pass


func _playStaticAnim(body : Node2D) -> void:
	print("BZZZ")
	pass # Replace with function body.
