extends RigidBody2D

@export var num_coll_in_horde : int = 2

var target : Node2D
var speed : int = 400
var is_in_horde : bool = false
var num_collisions : int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_in_horde:
		return
	var direction : Vector2 = (target.position - position) * delta
	move_and_collide(direction)


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
