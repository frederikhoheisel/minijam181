extends Node2D

var blood_particle_scene : PackedScene = preload("res://entities/particles/blut.tscn")
var body_part_scene : PackedScene = preload("res://entities/particles/corpse.tscn")
var floor_blut_scene : PackedScene = preload("res://entities/particles/floor_blut.tscn")

func _ready() -> void:
	SignalBus.restart.connect(_on_restart)
	SignalBus.rabbit_died.connect(_on_rabbit_died)
	
func _on_rabbit_died(rabbit: RigidBody2D, death_type: String, pos: Vector2) -> void:
	if(rabbit.global_position != pos):
		print("ALARM") 
	
	var color: Color = rabbit.get_modulate()
	match death_type:
		"headshot": 
			rabbit.headshotted = true
			rabbit.play_anim("headshot")
			splatter(pos, color, false, true, 5)
			rabbit.reparent.call_deferred($GoreContainer, true)
			blood(color, pos)
			rabbit.get_node("HeadshotAudioPlayer").play()
		"landmine":
			rabbit.headshotted = true
			rabbit.play_anim("splatter")
			splatter(pos, color, true, true, 5)
			rabbit.reparent.call_deferred($GoreContainer, true)

			blood(color, pos)
		"rain":
			rabbit.reparent.call_deferred($GoreContainer, true)
			rabbit.z_index += 10
			rabbit.get_node("Sprite").modulate = Color(1, 1, 1, 1)
			#rabbit.modulate = Color(1, 1, 1, 1)
			rabbit.play_anim("electrocute")
		"river":
			rabbit.reparent.call_deferred($GoreContainer, true)
			rabbit.z_index += 10
			rabbit.apply_impulse(Vector2(-.1, .03))
			rabbit.play_anim("river")
		"mäher":
			rabbit.reparent.call_deferred($GoreContainer, true)
			rabbit.play_anim("splatter")
			rabbit.headshotted = true
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

func _on_restart() -> void:
	await get_tree().create_timer(2).timeout
	$Horde.position = Vector2(0,0)
	Stats.current_horde_size = 2
	$Horde.reset()
	
