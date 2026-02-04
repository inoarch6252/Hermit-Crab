extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	print("HITBOX:", body.name)

	if Global.is_hidden:
		return

	if body.has_method("take_damage"):
		body.take_damage(1)
