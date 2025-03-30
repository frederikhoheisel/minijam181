extends RigidBody2D

@export var num_coll_in_horde : int = 4

@export var target : Node2D
var speed : int = 400
var is_in_horde : bool = false
var num_collisions : int = 0



var last_pos : Vector2 = Vector2.ZERO
@export var movement_speed_thresshhold : float = 1.0
var is_idling : bool = true

var colors: Array = [Color(1.0, 1.0, 1.0, 1.0),
			  Color(0.5, 0.5, 0.5, 1.0),
			  Color(0.95, 0.55, 0.25, 1.0),
			  Color(0.8, 0.4, 0.1, 1.0)]

var color : Color

var dead: bool = false
var headshotted: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%Sprite.animation = "idle"
	color = colors[randi() % colors.size()]
	if randf()>0.9995:
		color = Color(0,0,0,1)
	self.modulate = color
	last_pos = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_in_horde:
		return
	if dead:
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

	$Sprite.rotation = -rotation
		


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

#gets enum for type of death plays animation accordinglyaw
func die(death_type: String) -> void:
	dead = true
	$CollisionShape2D5.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	var pos: Vector2 = global_position
	$".".z_index-= 1
	SignalBus.rabbit_died.emit(self, death_type, pos, color)

func _on_idle_anim_timer_timeout() -> void:
	if dead:
		if !headshotted:
			queue_free()
		return
		
	if not is_idling:
		return
	var rng : int = randi_range(0, 3)
	if rng == 0:
		%Sprite.play("idle_blink")
	elif rng == 1:
		%Sprite.play("idle_bob")
	$IdleAnimTimer.start()
	
func play_anim(anim: String) -> void:
	%Sprite.play(anim)




	
