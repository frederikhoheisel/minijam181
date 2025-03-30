extends Control

var locked : bool = false

func _ready() -> void:
	SignalBus.egg_found.connect(update_ui)
	SignalBus.in_safe_zone.connect(hide_ui)
	for i : int in 5:
		var texture_rect : TextureRect = get_child(0).get_child(0).get_child(i)
		texture_rect.set_instance_shader_parameter("should_be_colorless", true)

	
func _process(_delta) -> void:
	if Input.is_action_pressed("skip"):
		$CanvasLayer/StartScreen.hide()


func update_ui(eggId : int) -> void:
	if eggId == -1:
		return

	var texture_rect : TextureRect = get_child(0).get_child(0).get_child(eggId)
	print(texture_rect.get_instance_shader_parameter("should_be_colorless"))
	texture_rect.set_instance_shader_parameter("should_be_colorless", false)


func hide_ui(hide : bool) -> void:
	if hide:
		$CanvasLayer/TextureRect.show()
		$CanvasLayer/VolumeSlider.show()
		locked = true
	else:
		$CanvasLayer/TextureRect.hide()
		$CanvasLayer/VolumeSlider.hide()
		locked = false


	if !locked:
		return

	var vboxContainer : VBoxContainer = get_child(0).get_child(1)
	var newLabel : Label = Label.new()

	var labelSettings : LabelSettings = LabelSettings.new()
	labelSettings.font_size = 8

	#for i in range(0, vboxContainer.get_child_count()):
		#vboxContainer.get_child(i).queue_free()
#
	#if Stats.total_deaths > 0:
		#newLabel.text = "Total Deaths: " + str(Stats.total_deaths)
		#newLabel.label_settings = labelSettings
		#vboxContainer.add_child(newLabel)
#
	#newLabel = Label.new()
#
	#if Stats.mine_deaths > 0:
		#newLabel.text = "Mine Deaths: " + str(Stats.mine_deaths)
		#newLabel.label_settings = labelSettings
		#vboxContainer.add_child(newLabel)
#
	#newLabel = Label.new()
#
	#if Stats.hunter_deaths > 0:
		#newLabel.text = "Hunter Deaths: " + str(Stats.hunter_deaths)
		#newLabel.label_settings = labelSettings
		#vboxContainer.add_child(newLabel)
#
	#newLabel = Label.new()
#
	#if Stats.zap_deaths > 0:
		#newLabel.text = "Zap Deaths: " + str(Stats.zap_deaths)
		#newLabel.label_settings = labelSettings
		#vboxContainer.add_child(newLabel)
#
	#newLabel = Label.new()
#
	#if Stats.drown_deaths > 0:
		#newLabel.text = "Drown Deaths: " + str(Stats.drown_deaths)
		#newLabel.label_settings = labelSettings
		#vboxContainer.add_child(newLabel)
#
	#newLabel = Label.new()
#
	#if Stats.bird_deaths > 0:
		#newLabel.text = "Bird Deaths: " + str(Stats.bird_deaths)
		#newLabel.label_settings = labelSettings
		#vboxContainer.add_child(newLabel)
#
	#newLabel = Label.new()
#
	#if Stats.rasenmäher_deaths > 0:
		#newLabel.text = "Mower Deaths: " + str(Stats.rasenmäher_deaths)
		#newLabel.label_settings = labelSettings
		#vboxContainer.add_child(newLabel)
