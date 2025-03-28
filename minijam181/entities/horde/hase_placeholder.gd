extends RigidBody2D

var target : Node2D
var speed : int = 400
var is_in_horde : bool = false
var num_collisions = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_in_horde:
		var direction : Vector2 = (target.position - position) * delta
		move_and_collide(direction)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		return
	is_in_horde = true
	num_collisions += 1


func _on_area_2d_body_exited(body: Node2D) -> void:
	num_collisions -= 1
	if num_collisions == 0:
		is_in_horde = false
