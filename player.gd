extends CharacterBody2D

signal shoot(location)

const move_speed = 300

const l_boundary = 100
const r_boundary = 800

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("shoot", Vector2(position.x, (position.y - 10)))

func _physics_process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
		
	if position.x <= l_boundary and velocity.x < 0:
		velocity = Vector2.ZERO
	elif position.x >= r_boundary and velocity.x > 0:
		velocity = Vector2.ZERO
		
	move_and_slide()
