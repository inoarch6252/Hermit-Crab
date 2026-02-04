extends CanvasLayer

@onready var hearts := [
	$heart01,
	$heart02,
	$heart03
]

var base_scales: Array[Vector2] = []
var last_lives := 0

func _ready() -> void:
	# Kalplerin sahnedeki orijinal scale'lerini kaydet (senin ayarın neyse o)
	base_scales.clear()
	for h in hearts:
		base_scales.append(h.scale)

	last_lives = hearts.size()

func set_lives(lives: int) -> void:
	# Can azaldıysa: düşen kalplere pop animasyonu uygula
	if lives < last_lives:
		for i in range(lives, last_lives):
			if i >= 0 and i < hearts.size():
				_pop_and_hide(i)

	# Kalan kalpleri doğru görünür yap ve scale'lerini orijinale geri al
	for i in range(hearts.size()):
		if i < lives:
			hearts[i].visible = true
			hearts[i].scale = base_scales[i]

	last_lives = lives

func _pop_and_hide(index: int) -> void:
	var h: Node2D = hearts[index]
	h.visible = true
	h.scale = base_scales[index]

	var tw := get_tree().create_tween()
	tw.tween_property(h, "scale", base_scales[index] * 1.25, 0.08)
	tw.tween_property(h, "scale", base_scales[index] * 0.0, 0.10)
	tw.tween_callback(func():
		h.visible = false
		h.scale = base_scales[index]
	)
