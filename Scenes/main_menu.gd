extends Node2D

@onready var start_button: Button = $"start button"
@onready var achievement_button: Button = $"achievement button"
@onready var credit_button: Button = $"credit button"
@onready var quit_game_button: Button = $"quit game button"

func _ready() -> void:
	# Menü açılınca ilk fokus
	start_button.grab_focus()

	# (Opsiyonel) Joystick ile gezinme "takılmasın" diye
	start_button.focus_mode = Control.FOCUS_ALL
	achievement_button.focus_mode = Control.FOCUS_ALL
	credit_button.focus_mode = Control.FOCUS_ALL
	quit_game_button.focus_mode = Control.FOCUS_ALL
