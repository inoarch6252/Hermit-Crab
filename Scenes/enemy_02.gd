extends CharacterBody2D

var direction = 1
const SPEED = 100.0


@onready var abgrund_checker: RayCast2D = $RayCast2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var body_col: CollisionShape2D = $CollisionShape2D

var turn_cooldown := 0.0

func _ready() -> void:
	if anim:
		anim.play()

func _physics_process(delta: float) -> void:
	if body_col:
		body_col.disabled = Global.is_hidden

	# 2) cooldown
	if turn_cooldown > 0.0:
		turn_cooldown -= delta

	

	# 4) Turn: duvarda veya uçurumda dön
	if is_on_wall() or not abgrund_checker.is_colliding():
		direction *= -1
		if anim:
			anim.flip_h = direction < 0
		# RayCast yönünü de ters çevir (ön tarafa baksın)
		abgrund_checker.target_position.x = abs(abgrund_checker.target_position.x) * direction
		turn_cooldown = 0.15

	# 5) Move
	velocity.x = direction * SPEED
	move_and_slide()
	velocity.y = 0
	
func _on_hitbox_body_entered(body: Node) -> void:
	if body.name != "player crab":
		return


	if Global.is_hidden:
		return

	if body.has_method("take_damage"):
		body.take_damage(1)
