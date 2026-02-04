

extends Button

@onready var ui_click: AudioStreamPlayer = $ui_click
@onready var sfx_hover: AudioStreamPlayer = $sfx_hover

func _ready() -> void:
	scale = Vector2.ONE

func _on_pressed() -> void:
	ui_click.play()
	await get_tree().create_timer(0.05).timeout
	get_tree().quit()

func _on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)
	sfx_hover.play()

func _on_mouse_exited() -> void:
	scale = Vector2.ONE
