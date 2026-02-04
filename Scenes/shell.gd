extends Area2D

var taken := false

func _on_area_entered(area: Area2D) -> void:
	if taken:
		return

	taken = true

	$SFX_Collect.play()
	hide()
	$CollisionShape2D.disabled = true

	await $SFX_Collect.finished
	queue_free()
