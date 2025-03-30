extends Node2D

var blood_particle_scene : PackedScene = preload("res://entities/particles/blut.tscn")
var body_part_scene : PackedScene = preload("res://entities/particles/corpse.tscn")
var floor_blut_scene : PackedScene = preload("res://entities/particles/floor_blut.tscn")

func _ready() -> void:
	
	SignalBus.rabbit_died.connect(_on_rabbit_died)
	
func _on_rabbit_died(rabbit: RigidBody2D, death_type: String, pos: Vector2) -> void:
	if(rabbit.global_position != pos):
		print("ALARM") 
	
	var color: Color = rabbit.get_modulate()
	match death_type:
		"headshot": 
			rabbit.headshotted = true
			rabbit.play_anim("headshot")
			splatter(pos, color, false, true, 3)
			rabbit.reparent.call_deferred($GoreContainer, true)
			blood(color, pos)
			rabbit.get_node("HeadshotAudioPlayer").play()
		"landmine":
			rabbit.headshotted = true
			rabbit.play_anim("splatter")
			#print("Pre splatter: " + str(pos))
			splatter(pos, color, true, true, 3)
			#print("Post splatter: " + str(pos))
			rabbit.reparent.call_deferred($GoreContainer, true)
			#print("Post Reparent splatter: " + str(pos))

			blood(color, pos)
		"rain":
			rabbit.z_index+=10
			rabbit.modulate = Color(1, 1, 1, 1)
			rabbit.play_anim("electrocute")
			splatter(pos, color, true, true, 3)
		"default": 
			return
	

func splatter(pos: Vector2, color: Color, bodies: bool, blood: bool, amount: int) -> void:
	#print("In splatter: " + str(pos))
	for i in amount:
		if bodies:
			var body_part : PackedScene = body_part_scene
			var new_body_part : Node2D = body_part.instantiate()
			new_body_part.position = pos + Vector2(randi_range(-10, 10), randi_range(-10, 10))
			new_body_part.modulate = color
			$GoreContainer.add_child.call_deferred(new_body_part)
		if blood:
			var floor_blut : PackedScene = floor_blut_scene
			var new_floor_blut : Node2D = floor_blut.instantiate()
			new_floor_blut.position = pos + Vector2(randi_range(-10, 10), randi_range(-10, 10))
			$GoreContainer.add_child.call_deferred(new_floor_blut)		


func blood(color: Color, pos: Vector2) -> void:
	var new_blood_particle: Node2D = blood_particle_scene.instantiate()
	new_blood_particle.position = pos
	$GoreContainer.add_child.call_deferred(new_blood_particle)
	#print("somewhere:  " + str(new_blood_particle.global_position))
	new_blood_particle.release_body_parts(color)
