extends Button

func _on_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/lvl1_hermit_crab.tscn")
