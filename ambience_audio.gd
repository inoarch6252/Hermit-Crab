extends Node

@onready var p: AudioStreamPlayer = $AmbienceAudio

func _ready() -> void:
	print("AMBIENCE READY") 
	p.play()
