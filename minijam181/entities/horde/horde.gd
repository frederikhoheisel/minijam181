extends CharacterBody2D

@export var rabbit_scene : PackedScene
var rabbit : RigidBody2D

var num_rabbit : int = 1

#movement
@export var speed : int = 500
@export var friction : float = 0.01
@export var acceleration : float = 0.1


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
	var direction = get_input() * delta
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
	if Input.is_action_just_pressed("rabbit_inc"):
		num_rabbit += 1
		spawn_in_area()
		#spawn_along_spiral_curve()
	#if Input.is_action_just_pressed("rabbit_dec"):
		#num_rabbit -= 1
		#spawn_along_spiral_curve()

var spiral_turns : float = 3.0
var spiral_spread : float = 500.0
var max_rabbit : int = 64

func spawn_in_area():
	var randx : float = randf_range(-10, 10)
	var randy : float = randf_range(-10, 10)
	var new_rabbit = rabbit.duplicate()
	new_rabbit.target = %RabbitContainer
	new_rabbit.position = Vector2(randx, randy)
	%RabbitContainer.add_child(new_rabbit)

func spawn_along_spiral_curve():
	print(num_rabbit)
	
	var t : float = float(num_rabbit) / (max_rabbit - 1)
	var angle : float = t * spiral_turns * TAU
	var radius : float = t * spiral_spread
	
	var x : float = cos(angle) * radius
	var y : float = sin(angle) * radius
	
	var new_rabbit = rabbit.duplicate()
	%RabbitContainer.add_child(new_rabbit)
	
	print("x: " + str(x))
	print("y: " + str(y))
	new_rabbit.position.x = x + position.x
	new_rabbit.position.y = y + position.y
