extends Sprite2D

func _ready():
	# Sprite standardmäßig unsichtbar, außer die Shell wurde bereits gesammelt
	visible = Global.shell_collected
