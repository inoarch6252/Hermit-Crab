extends Node

var shell_collected: bool = false
var is_hidden: bool = false

var life_count = 3

func die():
	life_count = life_count - 1
	print("Anzahl Leben: ", + life_count)
	$"CanvasLayer/Live Counter".text = "LIVES: " + str(life_count)


func _on_body_entered(body: Node) -> void:
	if body is CharacterBody2D and body.has_method("take_damage"):
		body.take_damage(1)
