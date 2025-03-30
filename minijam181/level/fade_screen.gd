extends Control

@export var start_on_ready:bool = false
var children:Array[Node]
var index:int = 0

func _ready() -> void:
	if start_on_ready:
		start()

func start() -> void:
	$Background.show()
	children = $Elements.get_children()
	children[index].start()
	children[index].faded_out.connect(on_next_element)

func on_next_element() -> void:
	index += 1
	if index < children.size():
		children[index].start()
		children[index].faded_out.connect(on_next_element)
	else:
		print("done")
		$Background.hide()
