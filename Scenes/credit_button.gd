

extends Button

@onready var ui_click: AudioStreamPlayer = $ui_click
@onready var hover_sfx: AudioStreamPlayer = $sfx_hover

func _ready() -> void:
	scale = Vector2.ONE

func _on_pressed() -> void:
	ui_click.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().change_scene_to_file("res://Scenes/Credits_hermit_crab.tscn")


func _on_achievement_button_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)
	hover_sfx.play()

func _on_achievement_button_mouse_exited() -> void:
	scale = Vector2.ONE
