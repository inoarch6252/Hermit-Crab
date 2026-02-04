extends Panel  # oder CanvasLayer, je nachdem, wo du das Skript dran hast

@onready var dialog_box = $Dialogbox
@onready var character_sprite = $Character
@onready var text_label = $Text  # RichTextLabel

var typing_speed: float = 0.05
var _dialog_lines: Array = []
var _character_textures: Array = []
var _current_line: int = 0
var _full_text: String = ""
var _char_index: int = 0
var _typing_in_progress: bool = false
var _typing_accumulator: float = 0.0

func start_dialog(character_textures: Array, lines: Array) -> void:
	_dialog_lines = lines
	_character_textures = character_textures
	_current_line = 0
	dialog_box.show()
	text_label.clear()
	text_label.bbcode_enabled = false  # sehr wichtig
	visible = true
	_show_next_line()

func _show_next_line() -> void:
	if _current_line >= _dialog_lines.size():
		dialog_box.hide()
		text_label.clear()
		visible = false
		_typing_in_progress = false
		return

	_full_text = _dialog_lines[_current_line]

	if _character_textures.size() > _current_line:
		character_sprite.texture = _character_textures[_current_line]
	else:
		character_sprite.texture = null

	text_label.clear()
	_char_index = 0
	_typing_accumulator = 0.0
	_typing_in_progress = true
	_current_line += 1

func _process(delta: float) -> void:
	if _typing_in_progress:
		_typing_accumulator += delta
		while _typing_accumulator >= typing_speed:
			_typing_accumulator -= typing_speed
			_char_index += 1
			if _char_index > _full_text.length():
				_typing_in_progress = false
				text_label.text = _full_text
				break
			else:
				text_label.text = _full_text.substr(0, _char_index)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if _typing_in_progress:
			_typing_in_progress = false
			text_label.text = _full_text  # sofort fertig
		else:
			_show_next_line()
