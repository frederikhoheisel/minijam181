extends PathFollow2D


var path : Path2D
@export var timeToFinishPath : int = 10
var runningTime : float = 0

var startMoving : bool = true

func _ready() -> void:

    path = get_parent()
    pass

func _process(delta : float) -> void:
    if startMoving:
        progress_ratio = lerp(0, 1, (1.0 * runningTime) / timeToFinishPath)
        runningTime += delta
    pass


func move() -> void:
    pass
