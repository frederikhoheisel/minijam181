extends Area2D

@export var area_radius: int = 200
@export var damage_radius: int = 48
@export var speed: float = 1/2

@onready var bird: CollisionShape2D = $ShadowCollision

var screen_hight: float

var points: PackedVector2Array
var t  = 0.0
# maximum distance to new points
var dist: int = 64

var slowness:float = speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points = gen_path()
	points[0] = bird.position
	screen_hight = DisplayServer.window_get_size()[1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#check if p2 was reached, then generate new point and reset t
	if t >= 1.0:
		#points[0] = points[1]
		#points[1] = points[2]
		#points[2] = Vector2(gen_point())
		points = gen_path()
		points[0] = bird.position
		
		t = 0.0
		
	t = t + delta * 1/3
	
	bird.position = quadratic_bezier(points, t)
	print(t)

func quadratic_bezier(points: PackedVector2Array, _t: float) -> Vector2:
	var q0 = points[0].lerp(points[1], _t)
	var q1 = points[1].lerp(points[2], _t)
	
	var r = q0.lerp(q1, _t)
	return r
	
	
func gen_path() -> PackedVector2Array:
	
	var points: PackedVector2Array

	#generate new points
	while points.size() <= 3:
			points.append(gen_point() + bird.position)
			
	return points
		
func gen_point() -> Vector2:
	var new_pos = Vector2(randf_range(-dist, dist),randf_range(-dist, dist))
		
	#if generated position is not outside thread area, add to array
	if !((bird.global_position + new_pos) - global_position).length() > area_radius:
		return new_pos
	else:
		return gen_point()


func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("IsRabbit"):
		print("bird kills rabbit!")
		slowness = 0
		$KillCollision.position = bird.position
		$StopTimer.start(3)
		$KillTimer.start(1)
		


func _on_kill_timer_timeout() -> void:
	if $KillCollision.disabled:
		$KillCollision.disabled = false
		$KillSprite.visible = true
		$KillSprite/AnimationPlayer.play()
		$KillTimer.start(0.1)
	else:
		$KillCollision.disabled = true


func _on_stop_timer_timeout() -> void:
	slowness = speed


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$KillSprite.visible = false
