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
	next_shot_in = shot_cooldown_secs

func _process(delta: float) -> void:
	try_set_target()
	if target != null:
		next_shot_in -= delta
		if next_shot_in <= 0:
			shoot(target)
			try_set_target()
			next_shot_in = shot_cooldown_secs
	else:
		next_shot_in = shot_cooldown_secs

func try_set_target():
	if target == null && targets_in_range.size() > 0:
		target = targets_in_range[0]

func shoot(rabbit:Node2D) -> void:
	rabbit.die()
