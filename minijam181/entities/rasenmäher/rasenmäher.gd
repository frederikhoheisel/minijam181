extends PathFollow2D


var path : Path2D
@export var timeToFinishPath : int = 10
var runningTime : float = 0
var lastPosition : Vector2
@export var strength : int = 1
@export var amplitude : float = 1

var startMoving : bool = true

func _ready() -> void:

	path = get_parent()
	lastPosition = position
	pass

func _process(delta : float) -> void:
	if startMoving:
		progress_ratio = lerp(0, 1, (1.0 * runningTime) / timeToFinishPath)
		runningTime += delta
	if lastPosition.x - position.x < 0:
		%Sprite2D.flip_h = true

	lastPosition = position


	%Sprite2D.position.y = sin(Time.get_ticks_msec() * 500) * strength + lastPosition.y




func _on_character_2d_body_entered(body : Node2D) -> void:
	if body.has_meta("IsRabbit"):
		body.die("mäher")
