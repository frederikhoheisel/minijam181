extends TileMapLayer

var flower_scene = preload("res://assets/background/flower.tscn")
@onready var flowers: Node = %flowers

@export var flower_num: int = 150
@export var bg_obj_area: Vector2 = Vector2(2500,2500)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var flower = flower_scene
	var flower_instance
	var pos: Vector2
	
	for n in flower_num:
		pos = Vector2(randf_range(-bg_obj_area.x, bg_obj_area.x), randf_range(-bg_obj_area.y, bg_obj_area.y))
		flower_instance = flower.instantiate()
		flower_instance.position = pos
		flowers.add_child(flower_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
