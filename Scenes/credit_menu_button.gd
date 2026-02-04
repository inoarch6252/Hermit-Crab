extends Button

func _on_pressed() -> void:
	var p: AudioStreamPlayer = get_parent().get_node_or_null("ui_click")
	if p:
		p.play()

	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://Scenes/hermit_crab.tscn")
