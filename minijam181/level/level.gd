extends Node2D

var body_part_scene : PackedScene = preload("res://entities/particles/corpse.tscn")
var floor_blut_scene : PackedScene = preload("res://entities/particles/floor_blut.tscn")

func _ready() -> void:
	SignalBus.splatter.connect(_on_splatter)
	
func _on_splatter(position: Vector2, color: Color, bodies: bool, blood: bool, amount: int) -> void:
	for i in amount:
		if bodies:
			var body_part : PackedScene = body_part_scene
			var new_body_part : Node2D = body_part.instantiate()
			print(global_position)
			new_body_part.position = position + Vector2(randi_range(-10, 10), randi_range(-10, 10))
			new_body_part.modulate = color
			$GoreContainer.add_child(new_body_part)
		if blood:
			var floor_blut : PackedScene = floor_blut_scene
			var new_floor_blut : Node2D = floor_blut.instantiate()
			new_floor_blut.position = position + Vector2(randi_range(-10, 10), randi_range(-10, 10))
			$GoreContainer.add_child(new_floor_blut)		
