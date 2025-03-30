extends Panel

func _on_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)
	#print(AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master")))
	
func _ready():
	$SliderNode.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master"))
