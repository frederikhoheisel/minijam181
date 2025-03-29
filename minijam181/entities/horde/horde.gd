extends CharacterBody2D

@export var rabbit_scene : PackedScene
var rabbit : RigidBody2D

var num_rabbit : int = 1

#movement
@export var speed : int = 300
@export var friction : float = 0.03
@export var acceleration : float = 0.03


func _ready() -> void:
	rabbit = rabbit_scene.instantiate()
	spawn_in_area()

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func _physics_process(delta):
	var direction: Vector2 = get_input() * delta
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
	if Input.is_action_just_pressed("rabbit_inc"):
		num_rabbit += 1
		spawn_in_area()

func spawn_in_area() -> void:
	var randx : float = randf_range(-10, 10)
	var randy : float = randf_range(-10, 10)
	var new_rabbit: RigidBody2D = rabbit.duplicate()
	new_rabbit.target = %RabbitContainer
	new_rabbit.position = Vector2(randx, randy)
	%RabbitContainer.add_child(new_rabbit)
