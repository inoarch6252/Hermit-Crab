extends Area2D

@export var next_scene: String = "res://Scenes/game_over.tscn"

func _ready() -> void:
	monitoring = true
	monitorable = true


	collision_mask = 0x7fffffff

	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D:
		get_tree().change_scene_to_file(next_scene)


func _on_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/lvl1_hermit_crab.tscn")
