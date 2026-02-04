extends CharacterBody2D

@onready var sfx_jump: AudioStreamPlayer = $sfx_jump
@onready var sfx_hide: AudioStreamPlayer = $sfx_hide
@onready var sfx_hit: AudioStreamPlayer = $sfx_hit

const SPEED := 300.0
const JUMP_VELOCITY := -400.0
const GRAVITY := 1200.0

var was_hidden := false

@export var max_lives := 3
var lives := 3
var invincible := false

@onready var hearts_ui := get_tree().get_first_node_in_group("hearts_ui")

func _ready() -> void:
	lives = max_lives
	if hearts_ui:
		hearts_ui.set_lives(lives)
	else:
		print("ERROR: Hearts UI bulunamadi (group: hearts_ui)")

func _physics_process(delta: float) -> void:
	# Hide
	Global.is_hidden = Input.is_action_pressed("ui_down") and is_on_floor()

	if Global.is_hidden and not was_hidden:
		sfx_hide.play()
	was_hidden = Global.is_hidden

	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	# Movement
	if Global.is_hidden:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			sfx_jump.play()

		var direction := Input.get_axis("ui_left", "ui_right")
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_animations()

func update_animations() -> void:
	var direction := Input.get_axis("ui_left", "ui_right")

	if Global.is_hidden:
		$AnimatedSprite2D.play("hide")
	else:
		if direction != 0:
			$AnimatedSprite2D.flip_h = (direction < 0)
			$AnimatedSprite2D.play("walk")
		else:
			$AnimatedSprite2D.play("default")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("shell"):
		print("shell collected")
		Global.shell_collected = true

func take_damage(amount := 1) -> void:
	if invincible:
		return

	sfx_hit.pitch_scale = randf_range(0.9, 1.1)
	sfx_hit.play()

	lives -= amount
	if lives < 0:
		lives = 0

	if hearts_ui:
		hearts_ui.set_lives(lives)

	invincible = true
	_blink(0.8, 0.08)
	await get_tree().create_timer(0.8).timeout
	invincible = false

	if lives <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _blink(duration := 0.8, interval := 0.08) -> void:
	var t := 0.0
	while t < duration:
		$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
		await get_tree().create_timer(interval).timeout
		t += interval
	$AnimatedSprite2D.visible = true
