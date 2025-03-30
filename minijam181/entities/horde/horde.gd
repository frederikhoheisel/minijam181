extends CharacterBody2D

@export var rabbit_scene : PackedScene

var size : int = 2

#movement
@export var speed : int = 300
@export var friction : float = 0.03
@export var acceleration : float = 0.03


func _ready() -> void:
	SignalBus.rabbit_died.connect(_on_rabbit_died)
	for i : int in size:
		spawn_in_area()
	SignalBus.fruit_eaten.connect(breed)


func get_input() -> Vector2:
	var input : Vector2 = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func _physics_process(delta : float) -> void:
	var direction: Vector2 = get_input() * delta
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
	if Input.is_action_pressed("rabbit_inc"):
		#Stats.current_horde_size += 1
		size += 1
		print("Rabbits: ", size)
		spawn_in_area()

func spawn_in_area() -> void:
	var randx : float = randf_range(-10, 10)
	var randy : float = randf_range(-10, 10)
	var rabbit : PackedScene = rabbit_scene
	var instance : RigidBody2D = rabbit.instantiate()
	var new_rabbit : RigidBody2D = instance.duplicate()
	new_rabbit.target = %RabbitContainer
	new_rabbit.position = Vector2(randx, randy)
	%RabbitContainer.call_deferred("add_child", new_rabbit)
	
func _on_rabbit_died(rabbit: RigidBody2D, death_type: String, pos: Vector2) -> void:
	size -= 1
	#Stats.current_horde_size -= 1
	print("Rabbits: ", size)
	


func breed() -> void:
	if size == 1:
		return
	#Stats.current_horde_size += 1
	var new_size : int = size * .5
	for i : int in new_size:
		spawn_in_area()
	$LoveParticles.emission_sphere_radius = size * 2
	$LoveParticles.amount = 2 * size
	$LoveParticles.emitting = true
func reset() -> void:
	for child in %RabbitContainer.get_children():
		child.queue_free()
	spawn_in_area()
	spawn_in_area()
