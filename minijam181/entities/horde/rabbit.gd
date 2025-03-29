extends RigidBody2D

@export var num_coll_in_horde : int = 4

@export var target : Node2D
var speed : int = 400
var is_in_horde : bool = false
var num_collisions : int = 0

var blood_particle : Node2D = preload("res://entities/particles/blut.tscn").instantiate()
var body_part : PackedScene = preload("res://entities/particles/corpse.tscn")

var last_pos : Vector2 = Vector2.ZERO
@export var movement_speed_thresshhold : float = 1.0
var is_idling : bool = true

var colors = [Color(0.5, 0.2, 0.0, 1.0),
			  Color(0.2, 0.1, 0.0, 1.0),
			  Color(0.6, 0.1, 0.4, 1.0),
			  Color(0.8, 0.4, 0.1, 1.0)]

var color : Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Sprite.animation = "idle"
	color = colors[randi() % colors.size()]
	%Sprite.modulate = color
	last_pos = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_in_horde:
		return
	var direction_to_center : Vector2 = (target.position - position) * delta
	move_and_collide(direction_to_center)
	
	var pseudo_speed = global_position - last_pos
	if abs(pseudo_speed.length()) > 1:
		%Sprite.scale.x = 1 if pseudo_speed.x > 0 else -1
	last_pos = global_position
	if pseudo_speed.length() > movement_speed_thresshhold:
		%Sprite.play("run")
		is_idling = false
	else:
		if not is_idling:
			%Sprite.animation = "idle"
		is_idling = true
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		return
	num_collisions += 1
	if num_collisions > num_coll_in_horde:
		is_in_horde = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	num_collisions -= 1
	if num_collisions <= num_coll_in_horde:
		is_in_horde = false


func die():
	get_tree().root.add_child(blood_particle)
	blood_particle.position = global_position
	blood_particle.release_body_parts(color)
	
	var test = body_part
	var instance = test.instantiate()
	instance.position = global_position
	get_tree().root.add_child(instance)
	queue_free()


func _on_idle_anim_timer_timeout() -> void:
	if not is_idling:
		return
	var rng : int = randi_range(0, 3)
	if rng == 0:
		%Sprite.play("idle_blink")
	elif rng == 1:
		%Sprite.play("idle_bob")
	$IdleAnimTimer.start()
