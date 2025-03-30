extends Node

func _on_credits_finished() -> void:
	get_tree().change_scene_to_file("res://level/level.tscn")
