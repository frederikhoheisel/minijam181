extends Node2D

@export var shot_cooldown_secs:float = 1.0
var next_shot_in:float
var targets_in_range:Array[Node]
var target:Node

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.get_meta("IsRabbit"):
		targets_in_range.append(body)


func _on_detection_area_body_exited(body: Node2D) -> void:
	if targets_in_range.has(body):
		targets_in_range.erase(body)

func _ready() -> void:
	reset_cooldown()

func _process(delta: float) -> void:
	try_set_target()
	if target != null:
		next_shot_in -= delta
		if next_shot_in <= 0:
			shoot(target)
			try_set_target()
			reset_cooldown()
	else:
		reset_cooldown()
		$Line2D.clear_points()
	update_line(delta)

func update_line(delta: float):
	if target != null:
		if $Line2D.points.size() == 2:
			var prev_point:Vector2 = $Line2D.get_point_position(1)
			$Line2D.clear_points()
			$Line2D.add_point(position, 0)
			$Line2D.add_point(adjust_line_point(prev_point.move_toward(target.global_position, delta * 400)), 1)
		else:
			$Line2D.clear_points()
			$Line2D.add_point(position, 0)
			$Line2D.add_point(adjust_line_point(target.global_position), 1)
		$Line2D.show()
	else:
		$Line2D.hide()
		
func adjust_line_point(point: Vector2) -> Vector2:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, point)
	var result = space_state.intersect_ray(query)
	if result && result.collider.has_meta("IsRabbit"):
		return result.position
	else:
		return (point - position) * 100 + position

func reset_cooldown():
	next_shot_in = shot_cooldown_secs

func try_set_target():
	if target == null && targets_in_range.size() > 0:
		target = targets_in_range[0]

func shoot(rabbit:Node2D) -> void:
	rabbit.die()
